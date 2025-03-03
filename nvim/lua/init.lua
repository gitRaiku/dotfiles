vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    update_in_insert = true,
  }
)

require('lspconfig').verible.setup{}
require('lspconfig').quick_lint_js.setup{}

local opts = { noremap=true, silent=true }
local function quickfix()
    vim.diagnostic.goto_next()
    vim.lsp.buf.code_action({
        filter = function(a) return a.isPreferred end,
        apply = true
    })
end
vim.keymap.set('n', '<A-Return>', quickfix, opts)

--[[
require("zk").setup({
  picker = "fzf",
  lsp = {
    config = {
      cmd = { "zk", "lsp" },
      name = "zk",
    },
    auto_attach = {
      enabled = true,
      filetypes = { "markdown" },
    },
  },
})
--]]
