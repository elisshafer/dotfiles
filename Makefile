XDG_CONFIG_HOME ?= $(HOME)/.config
NVIM_CONFIG ?= $(env):$(LOCALAPPDATA)\nvim

ifeq ($(OS),Windows_NT)
	detected_OS = Windows
else
	detected_OS = $(shell uname)
endif


ifeq ($(detected_OS),Windows)
	LINK := cmd /c mklink
else
	LINK := ln -sf
endif


all: symlinks nvim_symlinks

debug:
	@echo "Home directory: $(HOME)"
	@echo "User: $(USER)"
	@echo "Path: $(PATH)"
	@echo "Detected OS: $(detected_OS)"
	@echo "LINK CMD: $(LINK)"
	@echo "XDG_CONFIG_HOME: $(XDG_CONFIG_HOME)"
	@echo "NVIM_CONFIG: $(NVIM_CONFIG)"

symlinks: $(patsubst %.symlink,~/.%,$(wildcard *.symlink))

~/.%: %.symlink
	$(LINK) $(CURDIR)/$< $@

nvim_symlinks: $(addprefix $(XDG_CONFIG_HOME)/nvim/lua/user/, $(notdir $(wildcard lua/user/*.lua)))

# Doesn't work for Windows.
$(XDG_CONFIG_HOME)/nvim/lua/user/%.lua: lua/user/%.lua
	mkdir -p $(@D)
	$(LINK) $(CURDIR)/$< $@

.PHONY: all symlinks nvim_symlinks
