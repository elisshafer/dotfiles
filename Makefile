all: symlinks nvim_symlinks

symlinks: $(patsubst %.symlink,~/.%,$(wildcard *.symlink))

~/.%: %.symlink
	ln -sf $(CURDIR)/$< $@

nvim_symlinks: $(addprefix $(XDG_CONFIG_HOME)/nvim/, $(wildcard lua/eli/*.lua))

$(XDG_CONFIG_HOME)/nvim/%.lua: lua/eli/%.lua
	mkdir -p $(@D)
	ln -sf $(CURDIR)/$< $@

.PHONY: all symlinks nvim_symlinks
