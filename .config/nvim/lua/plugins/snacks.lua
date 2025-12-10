-- ~/.config/nvim/lua/plugins/snacks.lua

return {
  -- This table block targets the 'folke/snacks.nvim' plugin
  {
    "folke/snacks.nvim",
    -- The 'opts' table merges with the default configuration provided by LazyVim extras
    opts = {
      -- Configuration for the explorer (file tree/sidebar) - usually <leader>e
      explorer = {
        hidden = true, -- **Shows hidden (dot) files**
      },

      -- Configuration for the general file picker - usually <leader>ff
      picker = {
        hidden = true, -- **Shows hidden (dot) files**
      },
    },
  },
}
