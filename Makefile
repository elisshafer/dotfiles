XDG_CONFIG_HOME ?= $(HOME)/.config

all: symlinks nvim_symlinks

symlinks: $(patsubst %.symlink,~/.%,$(wildcard *.symlink))

~/.%: %.symlink
	ln -sf $(CURDIR)/$< $@

nvim_symlinks: $(addprefix $(XDG_CONFIG_HOME)/nvim/lua/user/, $(notdir $(wildcard lua/user/*.lua)))

$(XDG_CONFIG_HOME)/nvim/lua/user/%.lua: lua/user/%.lua
	mkdir -p $(@D)
	ln -sf $(CURDIR)/$< $@

.PHONY: all symlinks nvim_symlinks
