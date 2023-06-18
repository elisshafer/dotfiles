-- lsp.lua

-- Import the lspconfig module
local lspconfig = require('lspconfig')

-- Setup LSP servers for various languages and tools
lspconfig.eslint.setup{}
lspconfig.gopls.setup{}
lspconfig.golangci_lint_ls.setup{}
lspconfig.graphql.setup{}
lspconfig.pyre.setup{}
lspconfig.lua_ls.setup{}
lspconfig.tsserver.setup{}
lspconfig.yamlls.setup{}

-- Function to enable snippet support for a given LSP server
local function enable_snippet_support(server_name)
    -- Create client capabilities and enable snippet support
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true

    -- Set up the LSP server with updated capabilities
    lspconfig[server_name].setup {
        capabilities = capabilities,
    }
end

-- Enable snippet support for JSON and HTML LSP servers
enable_snippet_support('jsonls')
enable_snippet_support('html')

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>l', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
      vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
      vim.api.nvim_set_keymap('i', '<C-space>', '<C-x><C-o>', {noremap = true, silent = true})

      -- Buffer local mappings.
      -- See `:help vim.lsp.*` for documentation on any of the below functions
      local opts = { buffer = ev.buf }
      vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
      vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
      vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
      vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
      vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
      vim.keymap.set('n', '<leader>wl', function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end, opts)
      vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
      vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
      vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
      vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
      vim.keymap.set('n', '<leader>f', function()
          vim.lsp.buf.format { async = true }
      end, opts)
  end,
})
