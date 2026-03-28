return {
  {
    "MagicDuck/grug-far.nvim",
    lazy = false,
    config = function()
      require("grug-far").setup({
        -- optional override options
        -- (defaults are usually fine)
      })
    end,
  }
}
