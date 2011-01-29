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

require 'optparse'

options  = {}
optparse = OptionParser.new do |opts|
  # Set a banner, displayed at the top of the help screen.
  opts.banner = "Usage: #{File.basename($0)} [options] file1 file2 ..."

  # TODO: example option
  options[:verbose] = false
  opts.on( '-v', '--verbose', 'Output more information' ) do
    options[:verbose] = true
  end

  # TODO: example option
  options[:logfile] = nil
  opts.on( '-l', '--logfile FILE', 'Write log to FILE' ) do |file|
    options[:logfile] = file
  end

  # This displays the help screen
  opts.on( '-h', '--help', 'Display this help message' ) do
    puts opts
    exit
  end
end

# Parse using 'parse!' to remove all options found at ARGV
optparse.parse!

# Parse positional arguments
$args    = ARGV
$keyring = $args.shift
$action  = $args.shift
