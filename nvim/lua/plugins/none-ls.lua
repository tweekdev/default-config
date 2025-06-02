return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvimtools/none-ls-extras.nvim",
  },
  config = function()
    local null_ls = require("null-ls")
    local formatting = null_ls.builtins.formatting
    local diagnostics = null_ls.builtins.diagnostics
    local code_actions = null_ls.builtins.code_actions

    -- Configuration d'ESLint simple sans extra_args qui pourraient causer des problèmes
    local eslint_d = require("none-ls.diagnostics.eslint_d")

    -- Fonction d'attachement pour le formatage à la sauvegarde
    local format_on_save = function(client, bufnr)
      if client.supports_method("textDocument/formatting") then
        vim.api.nvim_create_autocmd("BufWritePre", {
          group = vim.api.nvim_create_augroup("LspFormatting", { clear = true }),
          buffer = bufnr,
          callback = function()
            vim.lsp.buf.format({ bufnr = bufnr, timeout_ms = 2000 })
          end,
        })
      end
    end

    -- Configuration principale de null-ls
    null_ls.setup({
      debug = false,
      sources = {
        -- ESLint pour les diagnostics (configuration simplifiée)
        eslint_d,

        -- Diagnostics
        require("none-ls.code_actions.eslint_d"),

        -- Formateurs
        formatting.prettier,
        formatting.stylua,
      },
      -- Appliquer le formatage à la sauvegarde
      on_attach = format_on_save,
    })

    -- Raccourci pour formatter avec conform
    vim.keymap.set("n", "<leader>gf", function()
      require("conform").format({ lsp_fallback = false })
    end, { desc = "Format via conform" })
  end,
}
