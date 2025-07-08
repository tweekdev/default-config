# Migration vers LazyVim - Guide Complet

## 🎯 Pourquoi migrer vers LazyVim ?

### Avantages selon la [documentation officielle](https://www.lazyvim.org/)
- 🔥 Configuration IDE complète pré-optimisée
- 💤 Gestion simplifiée avec lazy.nvim
- 🚀 Performance "blazingly fast"
- 🧹 Options par défaut sensées
- 📦 Plugins pré-configurés et prêts à l'emploi

## 📋 État actuel vs LazyVim

### ❌ Ce qui manque dans votre config actuelle
1. **Framework LazyVim non activé** dans `lua/config/lazy.lua`
2. **Aucun extra configuré** (TypeScript, Git, UI, etc.)
3. **Configuration manuelle** de 43+ plugins vs automatisée
4. **Keymaps non standardisés** LazyVim
5. **Pas de gestion des news/updates** LazyVim

### ✅ Ce qui est déjà compatible
- Structure de dossiers correcte
- Leader key sur espace
- lazy.nvim configuré
- Neovim v0.11.2 compatible

## 🚀 Plan de migration

### Étape 1: Backup de la config actuelle
```bash
cp -r ~/.config/nvim ~/.config/nvim-backup-$(date +%Y%m%d)
```

### Étape 2: Activer LazyVim dans lazy.lua
```lua
-- Dans lua/config/lazy.lua, ligne 26
spec = {
  { "LazyVim/LazyVim", import = "lazyvim.plugins" }, -- DÉCOMMENTER !
  { import = "plugins" },
},
```

### Étape 3: Configurer les extras recommandés
```lua
-- Dans lazyvim.json
{
  "extras": [
    "lazyvim.plugins.extras.lang.typescript",
    "lazyvim.plugins.extras.lang.json",
    "lazyvim.plugins.extras.ui.mini-animate",
    "lazyvim.plugins.extras.editor.harpoon2",
    "lazyvim.plugins.extras.coding.copilot",
    "lazyvim.plugins.extras.util.project"
  ]
}
```

### Étape 4: Simplifier les plugins redondants
Supprimer les plugins déjà inclus dans LazyVim :
- `telescope.lua` → Configuration auto LazyVim
- `lsp.lua` → Configuration auto LazyVim  
- `treesitter.lua` → Configuration auto LazyVim
- `neo-tree.lua` → Configuration auto LazyVim

### Étape 5: Adapter les keymaps
Utiliser les keymaps standards LazyVim ou les override proprement.

## 🔄 Migration douce (Alternative)

### Option: Garder config actuelle + LazyVim
```lua
-- lua/config/lazy.lua
spec = {
  { "LazyVim/LazyVim", import = "lazyvim.plugins" },
  { import = "plugins" }, -- Garde vos plugins custom
},
```

Cette approche permet :
- ✅ Bénéficier de LazyVim
- ✅ Garder vos plugins custom
- ⚠️ Risque de conflits à résoudre

## 🎯 Recommandation finale

**Pour votre cas spécifique :**
1. **Migration progressive** recommandée
2. **Commencer par activer LazyVim**
3. **Ajouter les extras TypeScript/Git**
4. **Éliminer progressivement les doublons**

## 📚 Ressources
- [Documentation LazyVim](https://www.lazyvim.org/)
- [Liste des extras](https://www.lazyvim.org/extras)
- [Configuration avancée](https://www.lazyvim.org/configuration) 