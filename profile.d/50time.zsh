#!/bin/zsh

# see zshparam(1)
#TIMEFMT=$'\nreal\t%E\nuser\t%U\nsys\t%S\ncpu\t%P\nmem\t%X+%Dk %Fpf+%Ww\nIO\t%I+%O\ncmd\t%J'
#TIMEFMT='real:%E  user:%U  sys:%S  cpu:%P mem:%X+%Dk %Fpf+%Ww  IO:%I+%O  %J'
TIMEFMT=$'real:%E  user:%U  sys:%S  cpu:%P mem:%X+%Dk %Fpf+%Ww  IO:%I+%O  %J\a\a'

# 起動したコマンドの「ユーザ消費時間+システム消費時間」が $REPORTTIME 秒よりも
# 大きいときに time 内部コマンドを指定したのと同じ情報が表示される。
# (zshの本 p.246 参照)
REPORTTIME=1
