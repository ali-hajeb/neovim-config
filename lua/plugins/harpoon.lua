return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local harpoon = require("harpoon")
    harpoon:setup({
      settings = {
        save_on_toggle = true, -- Save the Harpoon list when toggling the quick menu
        sync_on_ui_close = true, -- Sync the list when closing the UI
        key = function() return vim.loop.cwd() end, -- Use project-specific lists
      },
    })

    -- Keymaps for Harpoon
    vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end, { desc = "Harpoon: Add file to list" })
    vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Harpoon: Toggle quick menu" })
    vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end, { desc = "Harpoon: Go to file 1" })
    vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end, { desc = "Harpoon: Go to file 2" })
    vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end, { desc = "Harpoon: Go to file 3" })
    vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end, { desc = "Harpoon: Go to file 4" })
    vim.keymap.set("n", "<C-A-P>", function() harpoon:list():prev() end, { desc = "Harpoon: Previous file" })
    vim.keymap.set("n", "<C-A-N>", function() harpoon:list():next() end, { desc = "Harpoon: Next file" })
  end,
}
