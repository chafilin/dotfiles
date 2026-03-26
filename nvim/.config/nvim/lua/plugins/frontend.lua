return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        cssls = {},
        emmet_language_server = {
          filetypes = {
            "astro",
            "css",
            "eruby",
            "html",
            "htmlangular",
            "htmldjango",
            "javascriptreact",
            "less",
            "pug",
            "sass",
            "scss",
            "svelte",
            "templ",
            "typescriptreact",
            "vue",
          },
        },
        html = {},
      },
    },
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = function(_, opts)
      local biome_filetypes = {
        "css",
        "graphql",
        "json",
        "jsonc",
      }
      local biome_import_filetypes = {
        "astro",
        "javascript",
        "javascriptreact",
        "svelte",
        "typescript",
        "typescriptreact",
        "vue",
      }

      opts.formatters_by_ft = opts.formatters_by_ft or {}
      opts.formatters = opts.formatters or {}
      opts.formatters["biome-organize-imports"] = { require_cwd = true }

      for _, ft in ipairs(biome_filetypes) do
        opts.formatters_by_ft[ft] = { "biome" }
      end

      for _, ft in ipairs(biome_import_filetypes) do
        opts.formatters_by_ft[ft] = { "oxlint", "biome-organize-imports", "biome" }
      end
    end,
  },
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = {
      linters_by_ft = {
        astro = { "oxlint" },
        javascript = { "oxlint" },
        javascriptreact = { "oxlint" },
        svelte = { "oxlint" },
        typescript = { "oxlint" },
        typescriptreact = { "oxlint" },
        vue = { "oxlint" },
      },
    },
  },
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}

      if not vim.tbl_contains(opts.ensure_installed, "oxlint") then
        table.insert(opts.ensure_installed, "oxlint")
      end
    end,
  },
}
