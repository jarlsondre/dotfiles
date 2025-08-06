-- Functionality for toggling diagnostics (inline errors etc.)
local diagnostics_active = true
local toggle_diagnostics = function()
  diagnostics_active = not diagnostics_active
  if diagnostics_active then
    vim.diagnostic.enable()
    print("Diagnostics enabled")
  else
    vim.diagnostic.disable()
    print("Diagnostics disabled")
  end
end


local lsp_attach = function(client, bufnr)
  local opts = { buffer = bufnr }
  vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
  vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
  vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
  vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
  vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
  vim.keymap.set('n', 'gr', '<cmd>Telescope lsp_references<cr>', opts)
  vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
  vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
  vim.keymap.set({ 'n', 'x' }, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
  vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
  vim.keymap.set('n', '<leader>fl', '<cmd>lua vim.diagnostic.open_float()<cr>', opts)
  vim.keymap.set('n', '<leader>dn', toggle_diagnostics, { desc = "Toggle diagnostics" })
end

local capabilities = require("cmp_nvim_lsp").default_capabilities()

require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = {
    -- Bash
    'bash-language-server',
    'beautysh',
    'shellcheck',

    'clang-format',
    'clangd',
    'codelldb',
    'cpptools',

    'latexindent',
    'texlab',

    'lua-language-server',
    -- Markdown
    'marksman',
    'sphinx-lint',

    -- Python
    'pyright',
    'ruff',

    'rust-analyzer',
  },

  handlers = {
    function(server_name)
      require('lspconfig')[server_name].setup({
        on_attach = lsp_attach,
        capabilities = capabilities
      })
    end,

    pyright = function()
      require('lspconfig').pyright.setup({
        settings = {
          python = {
            analysis = {
              typeCheckingMode = "standard",
              autoSearchPaths = true,
              diagnosticMode = "workspace",
              useLibraryCodeForTypes = true,
            },
          },
        },
      })
    end,
    texlab = function()
      capabilities.textDocument.completion.completionItem.snippetSupport = true

      require('lspconfig').texlab.setup({
        capabilities = capabilities,
        settings = {
          texlab = {
            build = {
              executable = "latexmk",
              args = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "%f" },
              onSave = true,
            },
            chktex = {
              onOpenAndSave = true,
              onEdit = true,
            },
            forwardSearch = {
              executable = "/Applications/Skim.app/Contents/SharedSupport/displayline",
              args = { "%l", "%f", "%p" }, -- Line, file, and PDF file
            },
            experimental = {
              snippetSupport = true, -- Ensure snippets are supported
            },
          },
        },
      })
    end,
  }
})
