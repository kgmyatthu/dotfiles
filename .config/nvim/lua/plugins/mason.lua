return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "ts_ls",
          "clangd",
          "rust_analyzer",
          "solidity_ls",
          "lua_ls",
          "gopls",
          "harper-ls",
        },
      })
      vim.lsp.config("harper_ls", {
        settings = {
          ["harper-ls"] = {
            linters = { SentenceCapitalization = false, SpellCheck = true },
          },
        },
      })
    end,
  },
}
