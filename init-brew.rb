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

unless (PREFIX + "opt/curl-ca-bundle/share/ca-bundle.crt").exist?
    xsystem(%W"brew install curl-ca-bundle")
end

commands = {
  'lv' => 'lv',
  'git' => 'git',
  'git-flow' => 'git-flow',
  'wget' => 'wget',
  'cocot' => 'cocot',
  'mosh' => 'mobile-shell',
  '7z' => 'p7zip',
  'emacs' => %w'emacs --cocoa --srgb --with-gnutls',
}
commands.each do |cmd, *formula|
  unless installed?(cmd)
    xsystem(%W"brew install" + formula.flatten)
  end
end

#unless installed?('gcc-4.2')
#  xsystem(%W"brew install https://github.com/adamv/homebrew-alt/raw/master/duplicates/apple-gcc42.rb")
#end

#unless installed?('emacs')
#  xsystem(%W"env CC=gcc-4.2 CXX=g++-4.2 brew install emacs --cocoa")
#end

if Dir.glob(File.expand_path("~/Library/Fonts/Ricty*.ttf")).empty?
  unless /^sanemat\/font$/ =~ `brew tap`
    xsystem(%W"brew tap sanemat/font")
  end
  xsystem(%W"brew install ricty")
  require 'fileutils'
  FileUtils::Verbose.cp(Dir.glob(PREFIX + "Cellar/ricty/*/share/fonts/Ricty*.ttf"), File.expand_path("~/Library/Fonts/"))
  xsystem(%W"fc-cache -vf")
  #xsystem(%W"defaults -currentHost write -globalDomain AppleFontSmoothing -int 2")
end

# Emacs
xsystem("brew linkapps")
# or ln -s /Users/kazu/homebrew/Cellar/emacs/24.3/Emacs.app /Applications
