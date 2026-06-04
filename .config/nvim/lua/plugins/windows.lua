return {
  {
    "anuvyklack/windows.nvim",
    dependencies = {
      "anuvyklack/middleclass",
      "anuvyklack/animation.nvim",
    },
    config = function()
      require("windows").setup({
        autowidth = {
          winwidth = 1.4,
        },
      })
    end,
  },
  "anuvyklack/middleclass",
  "anuvyklack/animation.nvim",
}
