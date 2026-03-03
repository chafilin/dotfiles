return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        "astro",
        "css",
        "graphql",
        "html",
        "javascript",
        "jsdoc",
        "json",
        "markdown",
        "markdown_inline",
        "scss",
        "svelte",
        "tsx",
        "typescript",
        "vue",
        "yaml",
      })
    end,
  },
}
