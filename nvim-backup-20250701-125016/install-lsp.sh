#!/bin/bash

# Script d'installation des serveurs LSP manquants
echo "🔧 Installation des serveurs LSP pour Neovim..."

# Vérifier si npm est installé
if ! command -v npm &> /dev/null; then
    echo "❌ npm n'est pas installé. Veuillez installer Node.js/npm d'abord."
    exit 1
fi

# Installation du serveur Lua via Mason (recommandé)
echo "🔧 Installation du serveur Lua via Mason..."
nvim --headless -c "MasonInstall lua-language-server" -c "qa" 2>/dev/null || echo "⚠️  Utilisez :MasonInstall lua-language-server dans Neovim"

# Fonction pour installer un package npm globalement
install_npm_package() {
    local package=$1
    local display_name=$2
    
    echo "📦 Installation de $display_name..."
    if npm install -g "$package"; then
        echo "✅ $display_name installé avec succès"
    else
        echo "❌ Erreur lors de l'installation de $display_name"
    fi
}

# Installation des serveurs LSP
echo "🚀 Installation des serveurs de langue..."

install_npm_package "@tailwindcss/language-server" "Tailwind CSS Language Server"
install_npm_package "vscode-langservers-extracted" "HTML/CSS/JSON Language Servers"
install_npm_package "emmet-ls" "Emmet Language Server"
install_npm_package "typescript-language-server" "TypeScript Language Server"
install_npm_package "typescript" "TypeScript"
install_npm_package "@astrojs/language-server" "Astro Language Server"
install_npm_package "eslint" "ESLint"
install_npm_package "prettier" "Prettier"

echo ""
echo "📋 Vérification des installations..."

# Fonction pour vérifier si une commande existe
check_command() {
    local command=$1
    local display_name=$2
    
    if command -v "$command" &> /dev/null; then
        echo "✅ $display_name: $(which $command)"
    else
        echo "❌ $display_name: Non trouvé"
    fi
}

# Vérification des serveurs installés
check_command "lua-language-server" "Lua Language Server"
check_command "tailwindcss-language-server" "Tailwind CSS"
check_command "vscode-html-language-server" "HTML"
check_command "vscode-css-language-server" "CSS"
check_command "emmet-ls" "Emmet"
check_command "typescript-language-server" "TypeScript"
check_command "astro-ls" "Astro"
check_command "eslint" "ESLint"
check_command "prettier" "Prettier"

echo ""
echo "🎉 Installation terminée !"
echo "💡 Redémarrez Neovim pour que les changements prennent effet."
echo "🔍 Utilisez :LspInfo dans Neovim pour vérifier l'état des serveurs." 