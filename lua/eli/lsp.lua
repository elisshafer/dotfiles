-- lsp.lua

-- Import the lspconfig module
local lspconfig = require('lspconfig')

-- Setup LSP servers for various languages and tools
lspconfig.gopls.setup{}
lspconfig.golangci_lint_ls.setup{}
lspconfig.pyre.setup{}
lspconfig.eslint.setup{}
lspconfig.graphql.setup{}
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

