#!/bin/bash

# Script de diagnostic et correction automatique pour Neovim
echo "🏥 Diagnostic complet de la configuration Neovim..."
echo "=================================================="

# Couleurs pour les messages
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Fonction pour afficher les messages colorés
print_status() {
    local status=$1
    local message=$2
    case $status in
        "OK")
            echo -e "${GREEN}✅ $message${NC}"
            ;;
        "WARNING")
            echo -e "${YELLOW}⚠️  $message${NC}"
            ;;
        "ERROR")
            echo -e "${RED}❌ $message${NC}"
            ;;
        "INFO")
            echo -e "${BLUE}ℹ️  $message${NC}"
            ;;
    esac
}

# Vérification de Neovim
echo "🔍 Vérification de Neovim..."
if command -v nvim &> /dev/null; then
    nvim_version=$(nvim --version | head -n1)
    print_status "OK" "Neovim installé: $nvim_version"
else
    print_status "ERROR" "Neovim n'est pas installé"
    echo "   Installation: brew install neovim"
    exit 1
fi

# Vérification de Git
echo ""
echo "🔍 Vérification de Git..."
if command -v git &> /dev/null; then
    git_version=$(git --version)
    print_status "OK" "Git installé: $git_version"
else
    print_status "ERROR" "Git n'est pas installé"
    echo "   Installation: brew install git"
fi

# Vérification de Node.js et npm
echo ""
echo "🔍 Vérification de Node.js/npm..."
if command -v node &> /dev/null; then
    node_version=$(node --version)
    print_status "OK" "Node.js installé: $node_version"
else
    print_status "ERROR" "Node.js n'est pas installé"
    echo "   Installation: brew install node"
fi

if command -v npm &> /dev/null; then
    npm_version=$(npm --version)
    print_status "OK" "npm installé: $npm_version"
else
    print_status "ERROR" "npm n'est pas installé"
fi

# Vérification des outils de compilation
echo ""
echo "🔍 Vérification des outils de compilation..."
if command -v make &> /dev/null; then
    print_status "OK" "make disponible"
else
    print_status "ERROR" "make n'est pas installé"
    echo "   Installation: xcode-select --install"
fi

if command -v gcc &> /dev/null || command -v clang &> /dev/null; then
    print_status "OK" "Compilateur C disponible"
else
    print_status "WARNING" "Aucun compilateur C détecté"
    echo "   Installation: xcode-select --install"
fi

# Vérification des serveurs LSP
echo ""
echo "🔍 Vérification des serveurs LSP..."

check_lsp_server() {
    local server=$1
    local command=$2
    local install_cmd=$3
    
    if command -v "$command" &> /dev/null; then
        print_status "OK" "$server disponible"
    else
        print_status "ERROR" "$server manquant"
        echo "   Installation: $install_cmd"
    fi
}

check_lsp_server "TypeScript" "typescript-language-server" "npm install -g typescript-language-server typescript"
check_lsp_server "Tailwind CSS" "tailwindcss-language-server" "npm install -g @tailwindcss/language-server"
check_lsp_server "HTML" "vscode-html-language-server" "npm install -g vscode-langservers-extracted"
check_lsp_server "CSS" "vscode-css-language-server" "npm install -g vscode-langservers-extracted"
check_lsp_server "Emmet" "emmet-ls" "npm install -g emmet-ls"
check_lsp_server "ESLint" "eslint" "npm install -g eslint"
check_lsp_server "Prettier" "prettier" "npm install -g prettier"

# Vérification des outils optionnels
echo ""
echo "🔍 Vérification des outils optionnels..."

check_optional_tool() {
    local tool=$1
    local install_cmd=$2
    
    if command -v "$tool" &> /dev/null; then
        print_status "OK" "$tool disponible"
    else
        print_status "WARNING" "$tool manquant (optionnel)"
        echo "   Installation: $install_cmd"
    fi
}

check_optional_tool "ripgrep" "brew install ripgrep"
check_optional_tool "fd" "brew install fd"
check_optional_tool "fzf" "brew install fzf"
check_optional_tool "lazygit" "brew install lazygit"

# Vérification des dossiers Neovim
echo ""
echo "🔍 Vérification des dossiers Neovim..."

check_directory() {
    local dir=$1
    local description=$2
    
    if [ -d "$dir" ]; then
        print_status "OK" "$description existe: $dir"
    else
        print_status "INFO" "Création de $description: $dir"
        mkdir -p "$dir"
    fi
}

check_directory "$HOME/.config/nvim" "Dossier de configuration"
check_directory "$HOME/.local/share/nvim" "Dossier de données"
check_directory "$HOME/.local/state/nvim" "Dossier d'état"
check_directory "$HOME/.cache/nvim" "Dossier de cache"

# Vérification des permissions
echo ""
echo "🔍 Vérification des permissions..."
config_dir="$HOME/.config/nvim"
if [ -w "$config_dir" ]; then
    print_status "OK" "Permissions d'écriture sur la configuration"
else
    print_status "ERROR" "Pas de permissions d'écriture sur $config_dir"
    echo "   Correction: chmod -R 755 $config_dir"
fi

# Diagnostic des configurations
echo ""
echo "🔍 Diagnostic des configurations..."

# Vérifier init.lua
if [ -f "$HOME/.config/nvim/init.lua" ]; then
    print_status "OK" "init.lua trouvé"
else
    print_status "ERROR" "init.lua manquant"
fi

# Vérifier lazy.nvim
if [ -d "$HOME/.local/share/nvim/lazy/lazy.nvim" ]; then
    print_status "OK" "lazy.nvim installé"
else
    print_status "WARNING" "lazy.nvim pas encore installé (normal au premier démarrage)"
fi

# Script de correction automatique
echo ""
echo "🛠️  Script de correction automatique..."
echo "========================================"

# Fonction de correction
fix_missing_tools() {
    echo ""
    print_status "INFO" "Correction automatique des outils manquants..."
    
    # Installer les serveurs LSP manquants
    if ! command -v typescript-language-server &> /dev/null; then
        echo "📦 Installation du serveur TypeScript..."
        npm install -g typescript-language-server typescript
    fi
    
    if ! command -v tailwindcss-language-server &> /dev/null; then
        echo "📦 Installation du serveur Tailwind CSS..."
        npm install -g @tailwindcss/language-server
    fi
    
    if ! command -v vscode-html-language-server &> /dev/null; then
        echo "📦 Installation des serveurs HTML/CSS/JSON..."
        npm install -g vscode-langservers-extracted
    fi
    
    if ! command -v emmet-ls &> /dev/null; then
        echo "📦 Installation d'Emmet..."
        npm install -g emmet-ls
    fi
    
    print_status "OK" "Correction automatique terminée"
}

# Proposer la correction automatique
echo ""
read -p "🔧 Voulez-vous lancer la correction automatique? (y/N): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    fix_missing_tools
fi

# Résumé et recommandations
echo ""
echo "📋 Résumé et recommandations..."
echo "================================"
print_status "INFO" "Commandes à exécuter dans Neovim :"
echo "   :checkhealth                    # Diagnostic complet"
echo "   :checkhealth nvim-treesitter   # Vérifier Treesitter"
echo "   :checkhealth lsp               # Vérifier LSP"
echo "   :Lazy sync                     # Synchroniser les plugins"
echo "   :TSUpdate                      # Mettre à jour Treesitter"
echo "   :LspInfo                       # Informations LSP"

echo ""
print_status "INFO" "Scripts utiles :"
echo "   ./nvim/install-lsp.sh          # Installer tous les serveurs LSP"
echo "   ./nvim/check-treesitter.sh     # Vérifier Treesitter"
echo "   ./nvim/clean.sh                # Nettoyer les caches"

echo ""
print_status "OK" "Diagnostic terminé ! 🎉"
echo "🚀 Redémarrez Neovim pour appliquer les changements." 