#!/bin/sh
# vim:set fileencoding=utf-8:

errno () {
    #perl -le 'print join"\n",map{$!=$_}@ARGV' "$@"
    perl -e 'print map{$!=$_;"$_: $!\n"}@ARGV' "$@"
}

why_exit () {
    if [ -z "$1" ]; then
        echo "$0 exit_status..."
    else
        ruby -e 'system("");ARGV.each{|x|p Marshal.load(Marshal.dump($?)[/.*status/]+Marshal.dump(x.to_i)[/i.*/n])}' "$@"
    fi
}

# http://blog.livedoor.jp/dankogai/archives/50693640.html
charnames () {
    local c
    for c in "$@"; do
        echo "$c" | perl -Mencoding=utf8 -MHTML::Entities -Mcharnames=:full -ple \
            '$o=ord; $_=sprintf"$_ U+%04X %s", $o, charnames::viacode($o)'
    done
#my %ord2name = split /[\t\n\r]/, do "unicore/Name.pl"; # ここが決め手
#
#binmode STDOUT, ":utf8";
#for my $ord (sort keys %ord2name){
#  printf "%s U+%s %s\n", chr(hex($ord)), $ord, $ord2name{$ord};
#}
}

# Local Variables:
# coding: utf-8
# indent-tabs-mode: nil
# End:
