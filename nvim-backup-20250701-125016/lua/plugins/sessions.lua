return {
  "olimorris/persisted.nvim",
  event = "VimEnter",
  keys = {
    { "<leader>ss", "<cmd>SessionSave<cr>", desc = "Save session" },
    { "<leader>sl", "<cmd>SessionLoad<cr>", desc = "Load session" },
    { "<leader>sd", "<cmd>SessionDelete<cr>", desc = "Delete session" },
    { "<leader>sf", "<cmd>Telescope persisted<cr>", desc = "Find session" },
  },
  opts = {
    save_dir = vim.fn.expand(vim.fn.stdpath("data") .. "/sessions/"), -- Répertoire de stockage des sessions
    use_git_branch = true,       -- Créer une session par branche git
    autosave = true,             -- Sauvegarder automatiquement la session à la sortie
    autoload = true,             -- Charger automatiquement la dernière session au démarrage
    follow_cwd = true,           -- Changer de session si le répertoire de travail change
    allowed_dirs = nil,          -- Limiter les sessions à certains répertoires (nil = pas de limite)
    ignored_dirs = {             -- Répertoires à ignorer pour les sessions
      vim.fn.expand("$HOME"),  -- Ne pas sauvegarder de session pour le répertoire home
    },
    silent = false,              -- Afficher les notifications de sauvegarde/chargement
    telescope = {
      reset_prompt_after_deletion = true,  -- Réinitialiser l'input après suppression d'une session
    },
    autosave_ignore_filetypes = {   -- Types de fichiers à ignorer pour la sauvegarde auto
      "gitcommit",
      "gitrebase",
    },
    autosave_ignore_buftypes = {    -- Types de buffers à ignorer pour la sauvegarde auto
      "terminal",
      "quickfix",
      "nofile",
    },
  },
  config = function(_, opts)
    -- Configuration de base
    local persisted = require("persisted")
    persisted.setup(opts)
    
    -- Ajouter à _G pour un accès global
    _G.sessions = _G.sessions or {}
    
    -- Fonction pour sauvegarder avec un nom personnalisé
    _G.sessions.save_with_name = function()
      local name = vim.fn.input("Session name: ")
      if name ~= "" then
        vim.cmd("SessionSave " .. name)
        vim.notify("Session saved as '" .. name .. "'", vim.log.levels.INFO)
      end
    end
    
    -- Fonction pour ouvrir une session depuis Telescope
    _G.sessions.open_telescope = function()
      require("telescope").extensions.persisted.persisted()
    end
    
    -- Intégration avec Telescope
    require("telescope").load_extension("persisted")
    
    -- Ajout d'un raccourci pour sauvegarder avec nom
    vim.keymap.set("n", "<leader>sn", function() _G.sessions.save_with_name() end, { desc = "Save session with name" })
    
    -- Création d'un groupe d'autocommandes pour les sessions
    local sessions_group = vim.api.nvim_create_augroup("Persisted", { clear = true })
    
    -- Afficher un message lorsqu'une session est chargée
    vim.api.nvim_create_autocmd("User", {
      pattern = "PersistedLoadPost",
      group = sessions_group,
      callback = function()
        local session_name = persisted.get_current() or "default"
        vim.notify("Session chargée: " .. session_name, vim.log.levels.INFO)
      end,
    })
    
    -- Notification lors de la sauvegarde automatique
    vim.api.nvim_create_autocmd("User", {
      pattern = "PersistedSavePost",
      group = sessions_group,
      callback = function()
        local session_name = persisted.get_current() or "default"
        vim.notify("Session sauvegardée: " .. session_name, vim.log.levels.INFO)
      end,
    })
    
    -- Notification lors du changement automatique de session (lorsque le projet change)
    vim.api.nvim_create_autocmd("User", {
      pattern = "PersistedTelescopeLoadPost",
      group = sessions_group,
      callback = function()
        local session_name = persisted.get_current() or "default"
        vim.notify("Changement de session: " .. session_name, vim.log.levels.INFO)
      end,
    })
  end,
}
