return {
  -- Harpoon 2: Quick file bookmarking and navigation
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local harpoon = require("harpoon")
      harpoon:setup({
        settings = {
          save_on_toggle = true,
          sync_on_ui_close = true,
        },
      })

      -- Keybindings
      vim.keymap.set("n", "<leader>a", function()
        harpoon:list():add()
      end, { desc = "Harpoon: Add file" })

      vim.keymap.set("n", "<leader>h", function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end, { desc = "Harpoon: Toggle menu" })

      -- Navigate to specific files
      vim.keymap.set("n", "<leader>1", function()
        harpoon:list():select(1)
      end, { desc = "Harpoon: File 1" })

      vim.keymap.set("n", "<leader>2", function()
        harpoon:list():select(2)
      end, { desc = "Harpoon: File 2" })

      vim.keymap.set("n", "<leader>3", function()
        harpoon:list():select(3)
      end, { desc = "Harpoon: File 3" })

      vim.keymap.set("n", "<leader>4", function()
        harpoon:list():select(4)
      end, { desc = "Harpoon: File 4" })

      -- Navigate with Ctrl+n/p (doesn't conflict with Zellij's Alt keys)
      vim.keymap.set("n", "<C-S-P>", function()
        harpoon:list():prev()
      end, { desc = "Harpoon: Previous" })

      vim.keymap.set("n", "<C-S-N>", function()
        harpoon:list():next()
      end, { desc = "Harpoon: Next" })
    end,
  },

  -- Flash: Jump to any location with 2-3 keystrokes
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {
      -- Default options
      labels = "asdfghjklqwertyuiopzxcvbnm",
      search = {
        multi_window = true,
        forward = true,
        wrap = true,
      },
      jump = {
        autojump = false,
      },
      label = {
        uppercase = false,
        rainbow = {
          enabled = false,
          shade = 5,
        },
      },
      modes = {
        char = {
          enabled = true,
          autohide = false,
          jump_labels = true,
        },
      },
    },
    keys = {
      {
        "s",
        mode = { "n", "x", "o" },
        function()
          require("flash").jump()
        end,
        desc = "Flash",
      },
      {
        "S",
        mode = { "n", "x", "o" },
        function()
          require("flash").treesitter()
        end,
        desc = "Flash Treesitter",
      },
      {
        "r",
        mode = "o",
        function()
          require("flash").remote()
        end,
        desc = "Remote Flash",
      },
      {
        "R",
        mode = { "o", "x" },
        function()
          require("flash").treesitter_search()
        end,
        desc = "Treesitter Search",
      },
      {
        "<c-s>",
        mode = { "c" },
        function()
          require("flash").toggle()
        end,
        desc = "Toggle Flash Search",
      },
    },
  },

  -- Better quickfix and location list
  {
    "folke/trouble.nvim",
    cmd = { "Trouble", "TroubleToggle" },
    opts = {
      use_diagnostic_signs = true,
    },
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>cl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>xQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
  },
}
