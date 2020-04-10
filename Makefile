all: make_in_src

install: install_from_src

make_in_src:
	$(MAKE) -C src

install_from_src:
	$(MAKE) -C src install
