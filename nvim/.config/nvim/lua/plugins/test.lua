return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "haydenmeade/neotest-jest",
    },
    opts = function(_, opts)
      opts.adapters = opts.adapters or {}

      table.insert(opts.adapters, require("neotest-jest")({
        env = { CI = true },
        cwd = function()
          return vim.fn.getcwd()
        end,
      }))
    end,
  },
}
