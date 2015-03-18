SHELL := /bin/sh
APPNAME = autopush
DEPS =
HERE = $(shell pwd)
BIN = $(HERE)/pypy/bin
VIRTUALENV = virtualenv
NOSE = $(BIN)/nosetests -s
TESTS = $(APPNAME)/tests
PYTHON = $(BIN)/pypy
INSTALL = $(BIN)/pip install
PATH := $(BIN):$(PATH)

BUILD_DIRS = bin build deps include lib lib64 lib_pypy lib-python site-packages


.PHONY: all build test clean clean-env

all:	build

$(BIN)/pip: $(BIN)/pypy
	wget https://bootstrap.pypa.io/get-pip.py
	$(PYTHON) get-pip.py
	rm get-pip.py

$(BIN)/nosetests:
	$(INSTALL) -r test-requirements.txt

$(BIN)/paster: lib $(BIN)/pip
	$(INSTALL) -r requirements.txt
	$(PYTHON) setup.py develop

clean-env:
	rm -rf $(BUILD_DIRS)

clean:	clean-env

build: $(BIN)/pip
	$(INSTALL) -r requirements.txt
	$(PYTHON) setup.py develop

test: $(BIN)/nosetests
	$(NOSE)
