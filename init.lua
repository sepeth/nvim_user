-- Remove trailing whitespaces
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*" },
  command = [[%s/\s\+$//e]],
})

-- Zoom in/out should work in Neovide
if vim.g.neovide == true then
  vim.api.nvim_set_keymap("n", "<D-=>", ":lua vim.g.neovide_scale_factor = math.min(vim.g.neovide_scale_factor + 0.1, 2.5)<CR>", { silent = true })
  vim.api.nvim_set_keymap("n", "<D-->", ":lua vim.g.neovide_scale_factor = math.max(vim.g.neovide_scale_factor - 0.1, 0.5)<CR>", { silent = true })
  vim.api.nvim_set_keymap("n", "<D-0>", ":lua vim.g.neovide_scale_factor = 1<CR>", { silent = true })
end

return {

  mappings = {

    n = {
      ["<D-p>"] = { function() require("telescope.builtin").find_files() end, desc = "Find files" },
      ["<C-k>"] = { ':lua require("dash").search(true, vim.fn.expand("<cword>"))<CR>', desc = "Find word under Dash.app"},
    },

  },

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
    },

    {
      "hrsh7th/nvim-cmp",

      -- override the options table that is used in the `require("cmp").setup()` call
      opts = function(_, opts)
        -- opts parameter is the default options table
        -- the function is lazy loaded so cmp is able to be required
        local cmp = require "cmp"

        opts.mapping['<C-b>'] = cmp.mapping.scroll_docs(-4)
        opts.mapping['<C-f>'] = cmp.mapping.scroll_docs(4)

        return opts
      end,
    },

    {
      "Kapeli/dash.nvim",
      lazy = false,
    },

  },

  colorscheme = "catppuccin",

}
