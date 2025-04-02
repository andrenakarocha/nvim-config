return {
  "nvim-telescope/telescope-file-browser.nvim",
  dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
  config = function ()
    local telescope = require('telescope')
    telescope.setup{
      extensions = {
        file_browser = {
          hijack_netrw = true
        },
      },
      defaults = {
        theme = "center",
        sorting_strategy = "ascending",
        layout_config = {
          horizontal = {
            prompt_position = "top",
            preview_width = 0.3,
          },
        },
      },
    }

    telescope.load_extension "file_browser"

    vim.keymap.set("n", "<space>fb", ":Telescope file_browser<CR>", { desc = 'Open Telescope File Browser'})
    -- open file_browser with the path of the current buffer
    vim.keymap.set("n", "<space>fb", ":Telescope file_browser path=%:p:h select_buffer=true<CR>", { desc = 'Open Telescope File Browser With the current path'})
  end
}
