.PHONY:: all
all::

all:: $(HOME)/.bashrc
$(HOME)/.bashrc:
	echo ". $$(pwd)/bashrc.bash" > $@
