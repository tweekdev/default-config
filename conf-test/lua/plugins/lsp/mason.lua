return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
    vim.defer_fn(function()
      local status_mason, mason = pcall(require, "mason")
      if not status_mason then
        vim.notify("Failed to load mason.nvim", vim.log.levels.ERROR)
        return
      end

      local status_mason_lspconfig, mason_lspconfig = pcall(require, "mason-lspconfig")
      if not status_mason_lspconfig then
        vim.notify("Failed to load mason-lspconfig", vim.log.levels.ERROR)
        return
      end

      local status_mason_tool_installer, mason_tool_installer = pcall(require, "mason-tool-installer")
      if not status_mason_tool_installer then
        vim.notify("Failed to load mason-tool-installer", vim.log.levels.ERROR)
        return
      end

      mason.setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
      })

      mason_lspconfig.setup({
        ensure_installed = {
          "ts_ls",
          "html",
          "cssls",
          "tailwindcss",
          "lua_ls",
          "emmet_ls",
        },
        automatic_installation = true,
      })

      mason_tool_installer.setup({
        ensure_installed = {
          "prettier",
          "stylua",
          "isort",
          "black",
          "pylint",
          "eslint_d",
        },
      })
    end, 100) -- Ajoute un délai de 100ms pour s'assurer que tout est bien chargé
  end,
}

