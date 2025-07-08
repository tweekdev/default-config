# Configuration Neovim LazyVim

## 🚀 Configuration complètement refaite avec LazyVim

Cette configuration Neovim a été entièrement refaite pour utiliser [LazyVim](https://lazyvim.github.io/) comme base, tout en conservant vos keymaps personnalisés.

## ✨ Fonctionnalités

### 🎨 Thèmes disponibles
- **TokyoNight** (par défaut) - Thème sombre moderne
- **Gruvbox** - Thème rétro populaire  
- **Catppuccin** - Thème pastel élégant

### 🔧 Plugins principaux
- **nvim-cmp** - Autocomplétion moderne (remplace blink-cmp)
- **nvim-treesitter** - Coloration syntaxique avancée
- **telescope.nvim** - Recherche fuzzy
- **neo-tree.nvim** - Explorateur de fichiers
- **trouble.nvim** - Diagnostics et références
- **gitsigns.nvim** - Intégration Git

### ⌨️ Keymaps personnalisés conservés
Tous vos keymaps personnalisés ont été préservés et adaptés pour LazyVim :

#### Navigation de base
- `<leader>ff` - Rechercher des fichiers
- `<leader>fg` - Recherche dans les fichiers  
- `<leader>fb` - Lister les buffers
- `<leader>e` - Ouvrir l'explorateur de fichiers

#### Git
- `<leader>Gg` - LazyGit
- `<leader>Gs` - Git status
- `<leader>Gb` - Git blame

#### Diagnostics
- `<leader>xx` - Ouvrir Trouble diagnostics
- `[d` / `]d` - Diagnostic précédent/suivant

## 🛠️ Structure de la configuration

```
~/.config/nvim/
├── init.lua                    # Point d'entrée principal
├── lua/
│   ├── config/
│   │   ├── lazy.lua           # Configuration Lazy.nvim + LazyVim
│   │   ├── options.lua        # Options Neovim personnalisées
│   │   ├── keymaps.lua        # Keymaps personnalisés
│   │   └── diagnostics.lua    # Configuration des diagnostics
│   └── plugins/
│       ├── colorscheme.lua    # Configuration des thèmes
│       ├── treesitter.lua     # Configuration Treesitter
│       ├── coding.lua         # Autocomplétion et snippets
│       └── [autres plugins]   # Plugins personnalisés
```

## 🎯 Changements principaux

### ✅ Ce qui a été fait
- ✅ Migration complète vers LazyVim
- ✅ Suppression des anciens systèmes conflictuels (blink-cmp, github-theme)
- ✅ Configuration moderne avec nvim-cmp
- ✅ Thèmes LazyVim standards (TokyoNight, Gruvbox, Catppuccin)
- ✅ Treesitter optimisé avec LazyVim
- ✅ Conservation de tous vos keymaps personnalisés
- ✅ Nettoyage des dépendances obsolètes

### 🔄 Améliorations
- **Performance** : Chargement plus rapide avec LazyVim
- **Maintien** : Configuration plus simple à maintenir
- **Compatibilité** : Utilise les standards LazyVim
- **Stabilité** : Moins de conflits entre plugins

## 🚀 Utilisation

### Changer de thème
```vim
:colorscheme tokyonight
:colorscheme gruvbox  
:colorscheme catppuccin
```

### Gestion des plugins
```vim
:Lazy                " Interface Lazy.nvim
:Lazy sync          " Synchroniser les plugins  
:Lazy clean         " Nettoyer les plugins inutilisés
```

### Commandes utiles
```vim
:checkhealth        " Vérifier l'état de la configuration
:TSUpdate          " Mettre à jour Treesitter
:Telescope         " Lancer Telescope
```

## 🎉 La configuration est maintenant prête !

Votre configuration Neovim est désormais basée sur LazyVim avec tous vos keymaps personnalisés préservés. Elle est plus moderne, plus stable et plus facile à maintenir.
