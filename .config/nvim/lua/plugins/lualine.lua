return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local function full_filepath()
      -- '%:p:~' gives absolute path and replaces home with '~'
      local path = vim.fn.expand("%:p:~")
      if path == "" then
        path = "[No Name]"
      end
      -- append a dot if buffer is modified (unsaved)
      if vim.bo.modified then
        path = path .. " ●"
      end
      return path
    end

    require("lualine").setup({
      options = {
        icons_enabled = true,
        theme = "powerline_dark",
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = {
          statusline = {},
          winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        always_show_tabline = true,
        globalstatus = false,
        refresh = {
          statusline = 100,
          tabline = 100,
          winbar = 100,
        },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = {
          {
            full_filepath,
            color = { fg = "#bbc2cf", gui = "bold" },
            padding = { left = 1, right = 1 },
          },
        },
        lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { full_filepath },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      winbar = {},
      inactive_winbar = {},
      extensions = {},
    })
  end,
}
