return {
    "echasnovski/mini.icons",
    lazy = true,
    opts = {
      file = {
        [".keep"] = { glyph = "󰊢", hl = "MiniIconsGrey" },
        ["devcontainer.json"] = { glyph = "", hl = "MiniIconsAzure" },
      },
      filetype = {
        dotenv = { glyph = "", hl = "MiniIconsYellow" },
      },
      lsp = {
        array = { glyph = "󰅪", hl = "MiniIconsOrange" },
        boolean = { glyph = "⊨", hl = "MiniIconsOrange" },
        class = { glyph = "󰌗", hl = "MiniIconsBlue" },
        color = { glyph = "󰏘", hl = "MiniIconsRed" },
        constant = { glyph = "󰏿", hl = "MiniIconsCyan" },
        constructor = { glyph = "", hl = "MiniIconsBlue" },
        enum = { glyph = "", hl = "MiniIconsYellow" },
        enummember = { glyph = "", hl = "MiniIconsYellow" },
        event = { glyph = "", hl = "MiniIconsRed" },
        field = { glyph = "󰜢", hl = "MiniIconsPurple" },
        file = { glyph = "󰈙", hl = "MiniIconsBlue" },
        folder = { glyph = "󰉋", hl = "MiniIconsBlue" },
        ['function'] = { glyph = "󰊕", hl = "MiniIconsGreen" },
        interface = { glyph = "", hl = "MiniIconsBlue" },
        keyword = { glyph = "󰌋", hl = "MiniIconsPurple" },
        method = { glyph = "󰆧", hl = "MiniIconsGreen" },
        module = { glyph = "", hl = "MiniIconsYellow" },
        namespace = { glyph = "󰌗", hl = "MiniIconsBlue" },
        null = { glyph = "󰟢", hl = "MiniIconsGrey" },
        number = { glyph = "", hl = "MiniIconsOrange" },
        object = { glyph = "󰅩", hl = "MiniIconsBlue" },
        operator = { glyph = "󰆕", hl = "MiniIconsGrey" },
        package = { glyph = "", hl = "MiniIconsYellow" },
        property = { glyph = "󰜢", hl = "MiniIconsPurple" },
        reference = { glyph = "󰈇", hl = "MiniIconsBlue" },
        snippet = { glyph = "", hl = "MiniIconsGreen" },
        string = { glyph = "󰀬", hl = "MiniIconsYellow" },
        struct = { glyph = "󰌗", hl = "MiniIconsBlue" },
        text = { glyph = "󰉿", hl = "MiniIconsGreen" },
        typeparameter = { glyph = "", hl = "MiniIconsBlue" },
        unit = { glyph = "󰑭", hl = "MiniIconsBlue" },
        value = { glyph = "󰎠", hl = "MiniIconsCyan" },
        variable = { glyph = "󰀫", hl = "MiniIconsPurple" },
      },
    },
    init = function()
      package.preload["nvim-web-devicons"] = function()
        -- Safely mock nvim-web-devicons with error handling
        local ok, mini_icons = pcall(require, "mini.icons")
        if ok and mini_icons.mock_nvim_web_devicons then
          mini_icons.mock_nvim_web_devicons()
        else
          -- Fallback if mini.icons fails to load
          vim.notify("mini.icons failed to mock nvim-web-devicons", vim.log.levels.WARN)
        end
        return package.loaded["nvim-web-devicons"]
      end
    end,
  }

