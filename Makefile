.PHONY:: all shellrc misc
all:: shellrc misc

shellrc:: $(HOME)/.bashrc
$(HOME)/.bashrc:
	echo ". $$(pwd)/bashrc.bash" > $@

shellrc:: $(HOME)/.bash_profile
$(HOME)/.bash_profile:
	echo ". ~/.bashrc" > $@

shellrc:: $(HOME)/.zshrc
$(HOME)/.zshrc:
	echo ". $$(pwd)/zshrc.zsh" > $@

misc:: $(HOME)/.gemrc
$(HOME)/.gemrc:
	echo "install: --no-rdoc --no-ri --format-executable" > $@
	echo "update: --no-rdoc --no-ri --format-executable" >> $@

# minimal .vimrc
misc:: $(HOME)/.vimrc
$(HOME)/.vimrc:
	echo "syntax on" > $@
	echo "set bg=dark" >> $@
	echo "set modeline" >> $@
	echo "set list" >> $@
	echo "set listchars=tab:>-,trail:~,nbsp:%,extends:>,precedes:<" >> $@
