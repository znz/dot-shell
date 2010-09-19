## from debian language-env
# カレントディレクトリのバックアップファイルを表示する
# (削除する際は "chkbackups | xargs rm" を実行のこと)
chkbackups () {
    /usr/bin/find . -maxdepth 1 -name "?*~" -o -name "?*.[bB][aA][kK]" -o -name ".[^.]?*~" -o -name ".[^.]?*.[bB][aA][kK]" -o -name "#*" -o -name "*.i" -o -name "PI????*"
}
chkbackups_deep () {
    /usr/bin/find . -name "?*~" -o -name "?*.[bB][aA][kK]" -o -name ".[^.]?*~" -o -name ".[^.]?*.[bB][aA][kK]" -o -name "#*" -o -name "*.i" -o -name "PI????*"
}
clean () {
    chkbackups | xargs rm -f
}
clean_deep () {
    chkbackups_deep
    echo "OK?"
    read
    chkbackups_deep | xargs rm -f
}
