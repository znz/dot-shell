#!/usr/bin/env ruby
require 'pathname'
PREFIX = Pathname.new(ENV['HOME']) + 'homebrew'
BIN_DIR = PREFIX + 'bin'

unless ENV['PATH'].split(':').include?(BIN_DIR)
  ENV['PATH'] = "#{BIN_DIR}:#{ENV['PATH']}"
end

def installed?(command)
  (BIN_DIR + command).executable?
end

def xsystem(args)
  p args
  system(*args) or abort(args.inspect)
end

unless installed?('brew')
  xsystem(%W"git clone https://github.com/mxcl/homebrew.git #{PREFIX}")
end

commands = {
  'lv' => 'lv',
  'git' => 'git',
  'wget' => 'wget',
  'cocot' => 'cocot',
  'mosh' => 'mobile-shell',
  '7z' => 'p7zip',
}
commands.each do |cmd, formula|
  unless installed?(cmd)
    xsystem(%W"brew install #{formula}")
  end
end

#unless installed?('gcc-4.2')
#  xsystem(%W"brew install https://github.com/adamv/homebrew-alt/raw/master/duplicates/apple-gcc42.rb")
#end

#unless installed?('emacs')
#  xsystem(%W"env CC=gcc-4.2 CXX=g++-4.2 brew install emacs --cocoa")
#end
