# 💻 Mac Dev Environment Setup

Ce dépôt contient un script Bash pour configurer rapidement un environnement de développement moderne sur macOS (Apple Silicon).

---

## 🛠️ Modes disponibles

Le script accepte un argument qui détermine ce qu'il exécute :

- `install` – Installe les outils et dépendances.
- `links` – Supprime les anciens fichiers de config et crée des symlinks vers les dotfiles.
- `all` – Exécute à la fois `install` et `links`.

---

## ▶️ Utilisation

```bash
chmod +x setup.sh
./setup.sh {install|links|all}
```

> **Note:** Le script peut exécuter plusieurs fois sans problème.

> **Note:** Le script ne modifie pas les fichiers de configuration existants. Il créera des symlinks vers les dotfiles.

Exemples :

```bash
./setup.sh install
./setup.sh links
./setup.sh all
```

## 📦 Ce que le script installe (`install` ou `all`)

- **Homebrew** – Gestionnaire de paquets macOS
- **Rosetta 2** – Compatibilité avec les applications Intel
- **Docker Desktop** – Version ARM64
- **Node.js** (via `nvm`), en version LTS
- **Yarn**, **TypeScript**
- **Neovim**, **tmux**, **fzf**, **bat**, **git**, **zsh**
- **eza**, **zoxide**, **gh**, **lazygit**, **coursier**, **starship**
- **ripgrep**, **git-flow-avh**, **gnu-tar**, **postgresql**, **pigz**
- **Google Cloud SDK**
- **Raycast**
- **Oh My Zsh**, avec :
  - `zsh-syntax-highlighting`
  - `zsh-autosuggestions`
- **Kitty** – Terminal moderne
- **Tmux Plugin Manager (TPM)**

---

## 🔗 Symlinks créés (`links` ou `all`)

Le script supprime les fichiers de configuration existants s’ils sont présents, puis crée des liens symboliques vers les dotfiles stockés dans `~/.config/dotfiles` :

- `~/.zshrc`
- `~/.tmux.conf`
- `~/.gitconfig`
- `~/.gitignore_global`
- `~/.z`
- `~/.config/nvim`
- `~/.config/kitty`
- `~/.config/sesh`
- `~/.config/starship.toml`

---

## 📝 Prérequis

- macOS avec puce Apple Silicon
- Dossier `~/.config/dotfiles` correctement structuré

---

## ⚠️ Avertissement

Ce script **écrasera vos fichiers de configuration existants**. Assurez-vous de les sauvegarder si nécessaire.
