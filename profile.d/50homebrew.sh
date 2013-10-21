if [ -f $HOME/homebrew/opt/curl-ca-bundle/share/ca-bundle.crt ]; then
  export SSL_CERT_FILE=$HOME/homebrew/opt/curl-ca-bundle/share/ca-bundle.crt
fi
