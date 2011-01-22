require 'gpgme'

module Schleuder
    # Wrapper for ruby-gpgme. Method naming is not strictly logical, this might
    # change but aliases will be set up then.
    class Crypt
      # Instantiates and stores password
      def initialize(password)
        @password = password
        @ctx = GPGME::Ctx.new
        # feed the passphrase into the Context
        @ctx.set_passphrase_cb(method(:passfunc))		
      end

      # Verify a gpg-signature. Use +signed_string+ if the signature is
      # detached. Returns a GPGME::SignatureResult
      def verify(sig, signed_string='')
        in_signed = ''
        if signed_string.empty?
          # verify +sig+ as cleartext (aka pgp/inline) signature
          Schleuder.log.debug 'No extra signed_string, verifying cleartext signature'
          output = GPGME.verify(sig) do |sig|
            in_signed = sig
          end
        else
          # verify detached signature
          Schleuder.log.debug 'Verifying detached signature'
          # Don't know why we need a GPGME::Data object this time but without gpgme throws exceptions
          plain = GPGME::Data.new
          GPGME.verify(sig, signed_string, plain) do |sig|
            in_signed = sig
          end
          output = signed_string
          
        end
        Schleuder.log.debug 'verify_result: ' + in_signed.inspect
        
        [output, in_signed]
      end
      
      # Decrypt a string.
      def decrypt(str)
        output = ""
        in_encrypted = nil
        in_signed = nil
        
        # TODO: return ciphertext if missing key. Sensible e.g. if it is part
        # of a nested MIME-message and encrypted to someone else on purpose.
        # Breaking if even the whole message is not decryptable is a job for
        # the processor.
        
        # return input instead of empty String if not encrypted
        unless str =~ /^-----BEGIN PGP MESSAGE-----/
          # match pgp-mime- and inline-pgp-signatures
          if str =~ /^-----BEGIN PGP SIG/
            Schleuder.log.debug 'found signed, not encrypted message, verifying'
            output, in_signed = verify(str)
          else
            Schleuder.log.debug 'found not signed, not encrypted message, returning input'
            output = str
          end
        else
          Schleuder.log.debug 'found pgp content, decrypting and verifying with gpgme'
          in_encrypted = true
          output = GPGME.decrypt(str, :passphrase_callback => method(:passfunc)) do |sig|
            in_signed = sig
          end
          if output.empty?
            Exception.new("Output from GPGME.decrypt was empty!")
          end
          # TODO: return mailadresses or keys instead of signature-objects?
        end
        [output, in_encrypted, in_signed]
      end
      
      # Encrypt a string to a single receiver and sign it. +receiver+ must be a
      # Schleuder::Member
      def encrypt_str(str, receiver)
        # encypt and sign and return encrypted data as string
        key = receiver.key || receiver.email
        GPGME.encrypt([key], str, {:passphrase_callback => method(:passfunc), :armor => true, :sign => true, :always_trust => true})
      end
      
      # Lists all public keys matching +pattern+. Returns an array of
      # GPGME::GpgKey's
      def list_keys(pattern='')
        GPGME.list_keys(pattern)
      end

      # Returns the GPGME::GpgKey matching +pattern+. Log an error if more than
      # one matches, because duplicated user-ids is a sensitive issue.
      def get_key(pattern)
        pattern = "<#{pattern}>" if pattern =~ /.*@.*/
        k = list_keys(pattern)
        if k.length > 1
          Schleuder.log.error "There's more than one key matching the pattern you gave me!\nPattern: #{pattern}\nkeys: #{k.inspect}"
          false
        else
          k.first
        end
      end
      
      # Signs +string+ with the private key of the list (aka detached signature)
      def sign(string)
        GPGME::detach_sign(string, {:armor => true, :passphrase_callback => method(:passfunc)})
      end

      # Clearsigns +string+ with the private key of the list
      def clearsign(string)
        GPGME::clearsign(string, {:armor => true, :passphrase_callback => method(:passfunc)})
      end
      
      # Exports the public key matching +keyid+ as ascii key block.
      def export(keyid)
        GPGME.export(keyid, :armor=>:true)
      end
      
      # Delete the public key matching +pattern+ from the public key ring of the
      # list
      def delete_key(key)
        key = get_key(key) if key.kind_of?(String)
        begin
          @ctx.delete_key(key)
          return true
        rescue => e
          return e
        end
      end
      
      # Import +keydata+ into public key ring of the list
      def add_key(keydata)
        GPGME.import(keydata)
      end

      def add_key_from_file(keyfile)
        add_key(File.read(keyfile))
      end

      private

      def passfunc(hook, uid_hint, passphrase_info, prev_was_bad, fd)
        io = IO.for_fd(fd, 'w')
        io.puts @password
        io.flush
      end

    end
end
