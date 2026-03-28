return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.laststatus = 0
  end,
}
