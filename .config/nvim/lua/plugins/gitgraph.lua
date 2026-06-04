return {
  "isakbm/gitgraph.nvim",
  dependencies = { "sindrets/diffview.nvim" },
  keys = {
    {
      "<leader>gg",
      function()
        require("gitgraph").draw({}, { all = true, max_count = 5000 })
      end,
      desc = "GitGraph - Draw",
    },
  },
  config = function()
    require("gitgraph").setup({
      symbols = {
        -- Commits
        commit = "",
        commit_end = "",
        merge_commit = "",
        merge_commit_end = "",

        -- Kitty branch-drawing glyphs
        GVER   = "",
        GHOR   = "",
        GCLD   = "",
        GCRD   = "╭",
        GCLU   = "",
        GCRU   = "",
        GLRU   = "",
        GLRD   = "",
        GLUD   = "",
        GRUD   = "",
        GFORKU = "",
        GFORKD = "",
      },
      format = {
        timestamp = "%d-%m-%Y",
        fields = { "branch_name", "tag" },
      },
      hooks = {
        on_select_commit = function(commit)
          vim.notify("DiffviewOpen " .. commit.hash .. "^!")
          vim.cmd(":DiffviewOpen " .. commit.hash .. "^!")
        end,
        on_select_range_commit = function(from, to)
          vim.notify("DiffviewOpen " .. from.hash .. "~1.." .. to.hash)
          vim.cmd(":DiffviewOpen " .. from.hash .. "~1.." .. to.hash)
        end,
      },
    })

    -- link gitgraph groups to built-in highlight groups
    local links = {
      GitGraphHash       = "Comment",
      GitGraphTimestamp  = "Comment",
      GitGraphAuthor     = "Identifier",
      GitGraphBranchName = "Statement",
      GitGraphBranchTag  = "Label",
      GitGraphBranchMsg  = "String",
      GitGraphBranch1    = "Statement",
      GitGraphBranch2    = "Identifier",
      GitGraphBranch3    = "Type",
      GitGraphBranch4    = "Constant",
      GitGraphBranch5    = "Special",
    }
    for group, target in pairs(links) do
      vim.api.nvim_set_hl(0, group, { link = target, default = false })
    end
  end,
}
