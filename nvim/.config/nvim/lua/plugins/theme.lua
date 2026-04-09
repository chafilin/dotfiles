return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = function(_, opts)
      opts.flavour = "macchiato"
      opts.integrations = vim.tbl_deep_extend("force", opts.integrations or {}, {
        navic = { enabled = true, custom_bg = "NONE" },
      })

      local existing = opts.custom_highlights
      opts.custom_highlights = function(colors)
        local base = type(existing) == "function" and existing(colors) or existing or {}

        return vim.tbl_deep_extend("force", base, {
          StatusLine = { fg = colors.text, bg = colors.base },
          StatusLineNC = { fg = colors.surface1, bg = colors.base },
          NeoTreeNormal = { fg = colors.text, bg = colors.base },
          NeoTreeNormalNC = { fg = colors.text, bg = colors.base },
          NeoTreeEndOfBuffer = { fg = colors.base, bg = colors.base },
        })
      end

      return opts
    end,
  },
}
