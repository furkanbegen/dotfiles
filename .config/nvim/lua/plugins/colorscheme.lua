return {
  {
    "LazyVim/LazyVim",
    opts = function(_, opts)
      vim.o.background = "dark"
      opts.colorscheme = "catppuccin-mocha"
    end,
  },
}
