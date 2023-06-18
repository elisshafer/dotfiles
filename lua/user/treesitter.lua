-- treesitter.lua

local status_ok, ts = pcall(require, "nvim-treesitter")
if not status_ok then
    return
end

local status_ok, ts_configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
    return
end

ts_configs.setup {
  ensure_installed = {
    "help", "dockerfile", "c", "go", "gomod", "graphql", "html", "http", "javascript", "json", "css", "rust",
    "lua", "make", "markdown", "proto", "python", "scala", "sql", "tsx", "typescript", "vim", "yaml",
  },
  sync_install = false,
  auto_install = true,

  highlight = {
    enable = true,
    disable = {},
    disable = function(lang, buf)
        local max_filesize = 100 * 1024
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        return ok and stats and stats.size > max_filesize
    end,
    additional_vim_regex_highlighting = false,
  },
}
