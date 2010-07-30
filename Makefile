.PHONY:: all
all::

all:: $(HOME)/.bashrc
$(HOME)/.bashrc:
	echo ". $$(pwd)/bashrc.bash" > $@

all:: $(HOME)/.bash_profile
$(HOME)/.bash_profile:
	echo ". ~/.bashrc" > $@
