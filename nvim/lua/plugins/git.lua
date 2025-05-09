-- Configuration Git complète et optimisée
return {
  -- Interface Git de base
  {
    "tpope/vim-fugitive",
    cmd = { "Git", "Gdiffsplit", "Gvdiffsplit", "Gedit", "Gsplit", "Gread", "Gwrite", "Ggrep", "Gmove", "Gdelete" },
    keys = {
      { "<leader>gs", "<cmd>Git<cr>", desc = "Git status" },
      { "<leader>gb", "<cmd>Git blame<cr>", desc = "Git blame" },
      { "<leader>gc", "<cmd>Git commit<cr>", desc = "Git commit" },
      { "<leader>gd", "<cmd>Gdiffsplit<cr>", desc = "Git diff split" },
      { "<leader>gr", "<cmd>Gread<cr>", desc = "Git read (checkout)" },
    },
  },

  -- Integration LazyGit (interface TUI Git)
  {
    "kdheepak/lazygit.nvim",
    cmd = "LazyGit",
    keys = {
      { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
      { "<leader>gl", "<cmd>LazyGitFilter<cr>", desc = "LazyGit Log" },
      { "<leader>gf", "<cmd>LazyGitFilterCurrentFile<cr>", desc = "File History" },
    },
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      vim.g.lazygit_floating_window_border_chars = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }
      vim.g.lazygit_floating_window_scaling_factor = 0.9
      vim.g.lazygit_use_neovim_remote = 0
    end,
  },

  -- Indicateurs Git en marge et commandes Git
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      -- Configuration globale
      _G.git = _G.git or {}
      
      -- Initialisation de gitsigns avec des options améliorées
      require("gitsigns").setup({
        signs = {
          add = { text = "│" },
          change = { text = "│" },
          delete = { text = "_" },
          topdelete = { text = "‾" },
          changedelete = { text = "~" },
          untracked = { text = "┆" },
        },
        current_line_blame = false,           -- Désactivé par défaut (peut être togglé)
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = "eol",
          delay = 300,
        },
        current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
        preview_config = {
          border = "rounded",
          style = "minimal",
        },
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns
          
          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end
          
          -- Actions Git
          map("n", "]c", function()
            if vim.wo.diff then
              return "]c"
            end
            vim.schedule(function()
              gs.next_hunk()
            end)
            return "<Ignore>"
          end, { expr = true, desc = "Git: Prochain changement" })
          
          map("n", "[c", function()
            if vim.wo.diff then
              return "[c"
            end
            vim.schedule(function()
              gs.prev_hunk()
            end)
            return "<Ignore>"
          end, { expr = true, desc = "Git: Changement précédent" })
          
          -- Actions sur les changements
          map("n", "<leader>ghs", gs.stage_hunk, { desc = "Git: Stage hunk" })
          map("n", "<leader>ghr", gs.reset_hunk, { desc = "Git: Reset hunk" })
          map("v", "<leader>ghs", function() gs.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end, { desc = "Git: Stage hunk" })
          map("v", "<leader>ghr", function() gs.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end, { desc = "Git: Reset hunk" })
          map("n", "<leader>ghS", gs.stage_buffer, { desc = "Git: Stage buffer" })
          map("n", "<leader>ghR", gs.reset_buffer, { desc = "Git: Reset buffer" })
          map("n", "<leader>ghu", gs.undo_stage_hunk, { desc = "Git: Undo stage hunk" })
          
          -- Prévisualisation et blame
          map("n", "<leader>ghp", gs.preview_hunk, { desc = "Git: Preview hunk" })
          map("n", "<leader>ghb", function() gs.blame_line { full = true } end, { desc = "Git: Blame line" })
          map("n", "<leader>ghB", gs.toggle_current_line_blame, { desc = "Git: Toggle blame" })
          
          -- Diff
          map("n", "<leader>ghd", gs.diffthis, { desc = "Git: Diff this" })
          map("n", "<leader>ghD", function() gs.diffthis('~') end, { desc = "Git: Diff with HEAD" })
          
          -- Mettre la touche espace en mode visuel pour sélectionner des hunks
          map("o", "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "Git: Select hunk" })
          map("x", "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "Git: Select hunk" })
        end,
      })
      
      -- Fonctions globales pour l'interaction avec Git
      _G.git.toggle_blame = function()
        require("gitsigns").toggle_current_line_blame()
      end
      
      _G.git.blame_line = function()
        require("gitsigns").blame_line({ full = true })
      end
      
      _G.git.preview_hunk = function()
        require("gitsigns").preview_hunk()
      end
      
      -- Créer un groupe d'autocommandes pour les éléments Git
      local git_augroup = vim.api.nvim_create_augroup("GitIntegration", { clear = true })
      
      -- Rafraîchir les signes Git après une sauvegarde
      vim.api.nvim_create_autocmd("BufWritePost", {
        group = git_augroup,
        pattern = "*",
        callback = function()
          if vim.b.gitsigns_head ~= nil then
            vim.cmd("Gitsigns refresh")
          end
        end,
      })
    end,
  },
  
  -- Visualiseur de diff avancé
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewFileHistory" },
    keys = {
      { "<leader>gdo", "<cmd>DiffviewOpen<cr>", desc = "DiffView: Open" },
      { "<leader>gdc", "<cmd>DiffviewClose<cr>", desc = "DiffView: Close" },
      { "<leader>gdh", "<cmd>DiffviewFileHistory %<cr>", desc = "DiffView: File History" },
      { "<leader>gdH", "<cmd>DiffviewFileHistory<cr>", desc = "DiffView: Project History" },
      { "<leader>gdf", "<cmd>DiffviewFocusFiles<cr>", desc = "DiffView: Focus Files" },
      { "<leader>gdt", "<cmd>DiffviewToggleFiles<cr>", desc = "DiffView: Toggle Files" },
    },
    config = function()
      require("diffview").setup({
        view = {
          default = {
            winbar_info = true,
          },
          merge_tool = {
            layout = "diff3_mixed",
            disable_diagnostics = true,
          },
        },
        enhanced_diff_hl = true,       -- Meilleure coloration des différences
        hooks = {
          diff_buf_read = function()
            vim.opt_local.wrap = false  -- Désactiver le retour à la ligne dans les diffs
            vim.opt_local.list = false  -- Cacher les caractères invisibles
          end,
        },
        keymaps = {
          view = {
            ["q"] = "<cmd>DiffviewClose<cr>",
          },
          file_panel = {
            ["q"] = "<cmd>DiffviewClose<cr>",
          },
        },
      })
    end,
  },
  
  -- Visualiseur de l'historique Git amélioré
  {
    "rbong/vim-flog",
    cmd = { "Flog", "Flogsplit" },
    dependencies = {
      "tpope/vim-fugitive",
    },
    keys = {
      { "<leader>gvl", "<cmd>Flog<cr>", desc = "Git: Visual Log" },
      { "<leader>gvs", "<cmd>Flogsplit<cr>", desc = "Git: Visual Log Split" },
    },
  },
}
