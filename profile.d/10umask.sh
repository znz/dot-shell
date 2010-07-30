# ファイルを作るとき、どんな属性で作るか。man umask 参照
# suexecはg+wだと動かないため、umask 002にはしない。
# [[ $UID > 0 && $UID == $GID ]] && umask 002 || umask 022
umask 022
