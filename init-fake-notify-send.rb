#!/usr/bin/ruby
# fake notify-send with byobu and screen backend
require 'pathname'
home = Pathname.new(ENV['HOME'])
fake_bin = home + 'opt/fake/bin'
fake_bin.mkpath
(fake_bin + 'notify-send').open('w', 0755) do |f|
  f.puts <<-'RUBY'
#!/usr/bin/env ruby
require 'tmpdir'
open("#{Dir.tmpdir}/notify-send.log", 'a+') do |f|
  f.puts ARGV.inspect
  message = ARGV[1].gsub(/(\d+) (\w+)/) do
    "#{$1}#{$2[0].upcase}"
  end.gsub(/\s+/, ' ')
  color = 'kw'
  case ARGV[7]
  when /failed/
    color = 'rw'
  when /success/
    color = 'gw'
  end
  f.puts "\005{= #{color}}#{message}\005{-}"
end
  RUBY
end

byobu_bin = home + '.byobu/bin'
byobu_bin.mkpath
(byobu_bin + '5_fake-notify-send').open('w', 0755) do |f|
  f.puts <<-'SH'
#!/bin/sh -e
tail -n1 ${TMPDIR:-${TMP:-${TEMP:-/tmp}}}/notify-send.log
  SH
end
