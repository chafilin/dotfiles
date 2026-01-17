return {
  -- 1) Install and configure typescript-tools
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      -- fire diagnostics less often
      publish_diagnostic_on = "insert_leave", -- or "change"
      -- give tsserver room (MB)
      tsserver_max_memory = 4096,

      settings = {
        -- isolate diagnostics to a separate process
        separate_diagnostic_server = true,

        -- keep completion/code actions snappy
        expose_as_code_action = "all", -- keeps actions async

        -- tsserver "format" options (cheap but explicit)
        tsserver_format_options = {
          semicolons = "insert",
        },

        -- *** these are the big wins in large repos ***
        tsserver_file_preferences = {
          -- cut suggestion/diagnostic churn while typing
          disableSuggestions = true,

          -- turn off inlay hints (expensive in monorepos)
          includeInlayParameterNameHints = "none",
          includeInlayVariableTypeHints = false,
          includeInlayFunctionLikeReturnTypeHints = false,
          includeInlayPropertyDeclarationTypeHints = false,
          includeInlayEnumMemberValueHints = false,

          -- reduce auto-import scanning
          includePackageJsonAutoImports = "off",
          includeCompletionsForModuleExports = false,
          includeCompletionsForImportStatements = true,
        },
      },

      -- small debounce to avoid event storms
      flags = { debounce_text_changes = 150 },

      -- turn off heavy LSP capabilities for this client
      on_attach = function(client, bufnr)
        if client.server_capabilities.semanticTokensProvider then
          client.server_capabilities.semanticTokensProvider = nil
        end
        if client.server_capabilities.codeLensProvider then
          client.server_capabilities.codeLensProvider = nil
        end
        if vim.lsp.inlay_hint then
          pcall(vim.lsp.inlay_hint.enable, false, { bufnr = bufnr })
        end
      end,
    },
    config = function(_, opts)
      require("typescript-tools").setup(opts)
    end,
  },

  -- 2) Make sure LazyVim doesn't also start tsserver/vtsls
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- Most LazyVim versions accept `enabled = false`:
        tsserver = { enabled = false },
        vtsls = { enabled = false },
        eslint = {
          settings = {
            workingDirectory = { mode = "auto" },
          },
        },
      },
      -- For older LazyVim versions, this prevents setup if `enabled` is ignored:
      setup = {
        tsserver = function()
          return true
        end, -- returning true skips default setup
        vtsls = function()
          return true
        end,
      },
    },
  },
}
