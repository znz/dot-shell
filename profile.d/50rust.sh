if [ -d "$HOME/.cargo/bin" ]; then
    my_append_path "$HOME/.cargo/bin"
else
    export CARGO_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/cargo"
    my_append_path "$CARGO_HOME/bin"
    export RUSTUP_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/rustup"
fi
