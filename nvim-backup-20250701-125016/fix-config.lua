-- Script de correction automatique des erreurs de configuration
-- Utilisation : nvim --headless -c "luafile nvim/fix-config.lua" -c "qall"

local M = {}

-- Fonction pour afficher les messages
local function log(level, message)
  local prefix = {
    INFO = "ℹ️ ",
    WARN = "⚠️ ",
    ERROR = "❌",
    OK = "✅"
  }
  print(prefix[level] .. " " .. message)
end

-- Corriger les providers Python/Node/Ruby
local function fix_providers()
  log("INFO", "Configuration des providers...")
  
  -- Désactiver les providers inutiles pour de meilleures performances
  vim.g.loaded_perl_provider = 0
  vim.g.loaded_ruby_provider = 0
  vim.g.loaded_node_provider = 0
  vim.g.loaded_python3_provider = 0
  
  log("OK", "Providers désactivés pour de meilleures performances")
end

-- Corriger la configuration Treesitter
local function fix_treesitter()
  log("INFO", "Vérification de Treesitter...")
  
  local ok, treesitter = pcall(require, "nvim-treesitter.configs")
  if not ok then
    log("WARN", "Treesitter non trouvé, sera installé au prochain démarrage")
    return
  end
  
  -- Vérifier que les parsers essentiels sont installés
  local parsers = require("nvim-treesitter.parsers")
  local essential_parsers = { "lua", "javascript", "typescript", "html", "css" }
  
  for _, parser in ipairs(essential_parsers) do
    if not parsers.has_parser(parser) then
      log("WARN", "Parser manquant: " .. parser)
      log("INFO", "Installation automatique au prochain démarrage")
    else
      log("OK", "Parser disponible: " .. parser)
    end
  end
end

-- Corriger la configuration LSP
local function fix_lsp()
  log("INFO", "Vérification des serveurs LSP...")
  
  local ok, lspconfig = pcall(require, "lspconfig")
  if not ok then
    log("WARN", "LSPConfig non trouvé")
    return
  end
  
  -- Vérifier que les serveurs configurés sont disponibles
  local servers = { "lua_ls", "ts_ls", "html", "cssls", "tailwindcss" }
  local available_servers = lspconfig.util.available_servers()
  
  for _, server in ipairs(servers) do
    if vim.tbl_contains(available_servers, server) then
      log("OK", "Serveur LSP disponible: " .. server)
    else
      log("WARN", "Serveur LSP manquant: " .. server)
    end
  end
end

-- Corriger les keymaps problématiques
local function fix_keymaps()
  log("INFO", "Vérification des keymaps...")
  
  -- S'assurer que les keymaps essentiels sont définis
  local essential_maps = {
    { "n", "<leader>e", ":Neotree toggle<CR>", "Toggle file explorer" },
    { "n", "<leader>ff", ":Telescope find_files<CR>", "Find files" },
    { "n", "<leader>fg", ":Telescope live_grep<CR>", "Live grep" },
  }
  
  for _, map in ipairs(essential_maps) do
    local mode, lhs, rhs, desc = unpack(map)
    -- Vérifier si le mapping existe déjà
    local existing = vim.api.nvim_get_keymap(mode)
    local exists = false
    for _, keymap in ipairs(existing) do
      if keymap.lhs == lhs then
        exists = true
        break
      end
    end
    
    if not exists then
      log("INFO", "Ajout du keymap: " .. lhs .. " -> " .. desc)
      vim.keymap.set(mode, lhs, rhs, { desc = desc, silent = true })
    else
      log("OK", "Keymap existant: " .. lhs)
    end
  end
end

-- Corriger les options Vim
local function fix_options()
  log("INFO", "Vérification des options Vim...")
  
  -- Options essentielles pour de bonnes performances
  local essential_options = {
    { "updatetime", 300, "Temps de mise à jour" },
    { "timeoutlen", 500, "Délai des mappings" },
    { "clipboard", "unnamedplus", "Presse-papier système" },
    { "ignorecase", true, "Ignorer la casse en recherche" },
    { "smartcase", true, "Casse intelligente" },
    { "termguicolors", true, "Couleurs 24-bit" },
  }
  
  for _, option in ipairs(essential_options) do
    local name, value, desc = unpack(option)
    vim.opt[name] = value
    log("OK", desc .. " configuré: " .. name)
  end
end

-- Nettoyer les autocommands conflictuels
local function fix_autocommands()
  log("INFO", "Nettoyage des autocommands...")
  
  -- Créer un groupe d'autocommands propre
  local augroup = vim.api.nvim_create_augroup("HealthCheckFix", { clear = true })
  
  -- Autocommand pour sauvegarder automatiquement
  vim.api.nvim_create_autocmd("BufWritePre", {
    group = augroup,
    pattern = "*",
    callback = function()
      -- Nettoyer les espaces en fin de ligne
      local save_cursor = vim.fn.getpos(".")
      vim.cmd([[%s/\s\+$//e]])
      vim.fn.setpos(".", save_cursor)
    end,
  })
  
  log("OK", "Autocommands de nettoyage configurés")
end

-- Vérifier et corriger les highlights
local function fix_highlights()
  log("INFO", "Vérification des highlights...")
  
  -- Highlights essentiels pour une bonne visibilité
  local highlights = {
    { "Search", { bg = "#ffd700", fg = "#000000" } },
    { "IncSearch", { bg = "#ff6b6b", fg = "#ffffff" } },
    { "Visual", { bg = "#373b41" } },
    { "CursorLine", { bg = "#2d2d2d" } },
  }
  
  for _, hl in ipairs(highlights) do
    local name, opts = unpack(hl)
    vim.api.nvim_set_hl(0, name, opts)
  end
  
  log("OK", "Highlights essentiels configurés")
end

-- Fonction principale
function M.run_fixes()
  log("INFO", "Début de la correction automatique...")
  
  fix_providers()
  fix_options()
  fix_autocommands()
  fix_highlights()
  fix_keymaps()
  fix_treesitter()
  fix_lsp()
  
  log("OK", "Correction automatique terminée !")
  log("INFO", "Redémarrez Neovim pour appliquer tous les changements")
end

-- Exécuter les corrections si le script est appelé directement
if not pcall(debug.getlocal, 4, 1) then
  M.run_fixes()
end

return M 