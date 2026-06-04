return {
  "numToStr/FTerm.nvim",
  config = function()
    require("FTerm").setup({
      cmd = { "zsh", "--login" },
    })
  end,
}
