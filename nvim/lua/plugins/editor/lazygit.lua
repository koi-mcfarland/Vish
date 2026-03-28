-- nvim v0.8.0
return {
  "kdheepak/lazygit.nvim",
  lazy = true,
  cmd = {
    "LazyGit",
    "LazyGitConfig",
    "LazyGitCurrentFile",
    "LazyGitFilter",
    "LazyGitFilterCurrentFile",
  },
  -- setting the keybinding for LazyGit with 'keys' is recommended in
  -- order to load the plugin when the command is run for the first time
  keys = {
    { "<leader>g", "<cmd>LazyGit<cr>", desc = "LazyGit" }
  },
  init = function()
    vim.g.lazygit_floating_window_scaling_factor = 1
    vim.g.lazygit_floating_window_winblend = 0 
    vim.g.lazygit_floating_window_border_chars = { "", "", "", "", "", "", "", "" }
  end,
}
