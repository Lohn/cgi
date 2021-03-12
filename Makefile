PREFIX ?= /usr/local
BINDIR ?= $(PREFIX)/bin

install:
	$(info Installing the library to $(BINDIR))
	@install -Dm755 ./lib/httplib.sh  $(BINDIR)/httplib

uninstall:
	$(info Removing library from $(BINDIR))
	@rm -f $(BINDIR)/httplib

test:
	$(info Running shellspec tests)
	@rm -rf ./coverage
	@shellspec --kcov

.PHONY: install uninstall test
