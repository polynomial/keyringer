#!/usr/bin/env ruby
#
# Keyringer secret management system.
#
# Copyright (C) 2011 Keyringer Development Team.
# 
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or any later version.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
# 
# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#

module Keyring
  class Repository
    def initialize
      @git = Backend::Git.new
    end

    # Check for a valid repository
    def exists?(path)
      File.directory?(path + '/.git')
    end

    def getConfigPath(path)
      path + '/config'
    end

    def create(path, url = nil)
      keys_path   = Keys.getPath(path)
      config_path = getConfigPath(path)

      if url
        raise "Path #{path} exists and is a git repository" if exists?(path)
        @git.clone(url, path)
      else
        @git.init(path)
      end

      # Setup folders
      FileUtils.mkdir_p keys_path
      FileUtils.mkdir_p config_path
      FileUtils.chmod(0700, path)

      # Reparse basedir to force absolute folder
      path = Pathname.new(path).realpath
      
      # Create recipients
      recipients = Keyring::Recipients.new(path)

      # TODO: if needed:
      # options, version, keys
      # save user config

      @git.add('.')

      # TODO: commit just if the repository status has changed
      @git.commit('Importing')
    end
  end
end
