-- Note: ~/.config/nvim/splash.lua (sourced from init.vim) overrides this with
-- the dashboard theme; the startify config below is the initial setup.
return {
  "goolord/alpha-nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("alpha").setup(require("alpha.themes.startify").config)
  end,
}
