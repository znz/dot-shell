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

#misc:: $(HOME)/.gemrc
#$(HOME)/.gemrc:
#	echo "install: --no-rdoc --no-ri --format-executable" > $@
#	echo "update: --no-rdoc --no-ri --format-executable" >> $@
#	echo "gemsrc_use_ghq: 1" >> $@

# minimal .vimrc
misc:: $(HOME)/.vimrc
$(HOME)/.vimrc:
	echo "syntax on" > $@
	echo "set bg=dark" >> $@
	echo "set modeline" >> $@
	echo "set list" >> $@
	echo "set listchars=tab:>-,trail:~,nbsp:%,extends:>,precedes:<" >> $@
	echo "set spell" >> $@

USER_NAME = John Doe
USER_EMAIL = john@example.com

$(HOME)/.gitconfig:
	git config --global user.name "$(USER_NAME)"
	git config --global user.email "$(USER_EMAIL)"
	"$$(pwd)/git-config.sh"

$(HOME)/.byobu:
	"$$(pwd)/init-byobu.sh"
