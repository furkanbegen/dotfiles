return {
  {
    "f-person/auto-dark-mode.nvim",
    lazy = false, -- Must be loaded early to detect theme on startup
    opts = {
      update_interval = 2000, -- Check theme every 2 seconds
      set_dark_mode = function()
        -- Set your preferred dark colorscheme and background here
        vim.o.background = "dark"
        vim.cmd.colorscheme("catppuccin-mocha") -- or tokyonight-moon
      end,
      set_light_mode = function()
        -- Set your preferred light colorscheme and background here
        vim.o.background = "light"
        vim.cmd.colorscheme("catppuccin-latte") -- or tokyonight-day
      end,
    },
    -- The plugin automatically handles detection on macOS, Linux (GTK/KDE), and Windows.
  },

  -- 3. (Optional) Remove the default LazyVim colorscheme setting
  -- If you had a previous colorscheme setting, you may want to remove it
  -- or override it to let the auto-dark-mode handle the initial setting.
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = nil, -- Clear the default to avoid conflicts
    },
  },
}
