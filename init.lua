return {
  plugins = {

    -- Theme
    {
      "catppuccin/nvim",
      name = "catppuccin",
      config = function()
        require("catppuccin").setup {
          flavour = "macchiato"
        }
      end,
    },

    { "justinmk/vim-sneak", lazy = false },

    {
      "nvim-telescope/telescope.nvim",

      -- the first parameter is the plugin specification
      -- the second is the table of options as set up in Lazy with the `opts` key
      config = function(plugin, opts)
        local actions = require "telescope.actions"

        -- run the core AstroNvim configuration function with the options table
        require("plugins.configs.telescope")(plugin, opts)

        opts.defaults.mappings.i["<C-n>"] = actions.move_selection_next
        opts.defaults.mappings.i["<C-p>"] = actions.move_selection_previous
        opts.defaults.mappings.i["<C-j>"] = actions.cycle_history_next
        opts.defaults.mappings.i["<C-k>"] = actions.cycle_history_prev
      end,
    }

  },

  colorscheme = "catppuccin",
}
