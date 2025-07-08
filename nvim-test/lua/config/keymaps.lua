-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set
local wk = require("which-key")

-- Leader key configuration
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Basic keymaps
map("i", "<C-c>", "<Esc>", { desc = "Exit insert mode with Ctrl+C" })
map("n", "<leader>h", ":nohlsearch<CR>", { desc = "Clear search highlighting" })
map("n", "<leader>w", "<cmd>wall!<CR>", { desc = "Save all files" })
map("n", "<leader>Q", "<cmd>wqall!<CR>", { desc = "Save and quit all" })
map("n", "<leader>b", "<cmd>BufferLinePick<CR>", { desc = "Buffer switcher" })
map("n", "<leader>pv", vim.cmd.Ex, { desc = "Open file explorer" })

-- Window management
-- Split windows
map("n", "<leader>|", vim.cmd.vs, { desc = "Split window vertically" })
map("n", "<leader>-", vim.cmd.sp, { desc = "Split window horizontally" })

-- Navigate between windows
map("n", "<c-h>", ":wincmd h<CR>", { desc = "Navigate to left window" })
map("n", "<c-j>", ":wincmd j<CR>", { desc = "Navigate to bottom window" })
map("n", "<c-k>", ":wincmd k<CR>", { desc = "Navigate to top window" })
map("n", "<c-l>", ":wincmd l<CR>", { desc = "Navigate to right window" })

-- Alternative window navigation with 's' prefix
map("n", "sh", "<C-w>h", { desc = "Move to left window" })
map("n", "sj", "<C-w>j", { desc = "Move to bottom window" })
map("n", "sk", "<C-w>k", { desc = "Move to top window" })
map("n", "sl", "<C-w>l", { desc = "Move to right window" })

-- Resize windows
map("n", "<C-S-h>", "<C-w><", { desc = "Decrease window width" })
map("n", "<C-S-l>", "<C-w>>", { desc = "Increase window width" })
map("n", "<C-S-k>", "<C-w>+", { desc = "Increase window height" })
map("n", "<C-S-j>", "<C-w>-", { desc = "Decrease window height" })

-- Telescope keymaps (LazyVim compatible)
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Live grep" })
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Find buffers" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Help tags" })
map("n", "<leader>fd", "<cmd>Telescope diagnostics<cr>", { desc = "Diagnostics" })
map("n", "<leader>fr", "<cmd>Telescope lsp_references<cr>", { desc = "LSP references" })
map("n", "<C-g>", "<cmd>Telescope git_files<cr>", { desc = "Git files" })

-- Diagnostics (LazyVim compatible)
map("n", "<leader>de", function() vim.diagnostic.enable() end, { desc = "Enable diagnostics" })
map("n", "<leader>dd", function() vim.diagnostic.disable() end, { desc = "Disable diagnostics" })
map("n", "<leader>df", function() vim.diagnostic.open_float() end, { desc = "Show diagnostic float" })
map("n", "[d", function() vim.diagnostic.goto_prev() end, { desc = "Previous diagnostic" })
map("n", "]d", function() vim.diagnostic.goto_next() end, { desc = "Next diagnostic" })

-- Neo-tree
map("n", "<leader>e", "<cmd>Neotree toggle<cr>", { desc = "Explorer NeoTree (Root Dir)" })
map("n", "<leader>E", "<cmd>Neotree toggle dir=getcwd()<cr>", { desc = "Explorer NeoTree (CWD)" })

-- Sessions (if available)
map("n", "<leader>sl", function()
  if pcall(require, "persistence") then
    require("persistence").load()
  end
end, { desc = "Load session" })
map("n", "<leader>ss", function()
  if pcall(require, "persistence") then
    require("persistence").save()
  end
end, { desc = "Save session" })
map("n", "<leader>sd", function()
  if pcall(require, "persistence") then
    require("persistence").stop()
  end
end, { desc = "Delete session" })

-- Specific tools
map("n", "<leader>mc", "<cmd>MetalsCompile<CR>", { desc = "Metals compile" })

-- Which-key configuration for group labels and advanced mappings
wk.add({
  -- Hidden groups
  { "<leader>a", hidden = true },

  -- Sessions
  { "<leader>s", group = "+sessions" },

  -- LSP and Code actions
  { "<leader>c", group = "+code" },
  { "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", desc = "Code action" },
  { "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", desc = "Rename" },
  { "<leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "LSP references (Trouble)" },
  { "<leader>cs", "<cmd>Trouble symbols toggle<CR>", desc = "Symbols (Trouble)" },

  -- Debugger
  { "<leader>d", group = "+debugger" },
  { "<leader>dt", "<cmd>DapToggleBreakpoint<CR>", desc = "Toggle Breakpoint" },
  { "<leader>dc", "<cmd>DapContinue<CR>", desc = "Continue" },
  { "<leader>dx", "<cmd>DapTerminate<CR>", desc = "Terminate" },
  { "<leader>do", "<cmd>DapStepOver<CR>", desc = "Step Over" },

  -- Git
  { "<leader>G", group = "+git" },
  { "<leader>Gs", "<cmd>Git<CR>", desc = "Git status" },
  { "<leader>Gg", "<cmd>LazyGit<CR>", desc = "LazyGit" },
  { "<leader>Gf", "<cmd>LazyGitFilterCurrentFile<CR>", desc = "File history" },
  { "<leader>Gl", "<cmd>LazyGitFilter<CR>", desc = "Git log" },
  { "<leader>Gb", "<cmd>Git blame<CR>", desc = "Git blame" },
  { "<leader>Gd", "<cmd>Gdiffsplit<CR>", desc = "Git diff split" },
  { "<leader>Gdo", "<cmd>DiffviewOpen<CR>", desc = "DiffView: Open" },
  { "<leader>Gdh", "<cmd>DiffviewFileHistory %<CR>", desc = "DiffView: File History" },
  { "<leader>Ghp", function()
    if pcall(require, "gitsigns") then
      require("gitsigns").preview_hunk()
    end
  end, desc = "Git: Preview hunk" },
  { "<leader>Ghb", function()
    if pcall(require, "gitsigns") then
      require("gitsigns").blame_line()
    end
  end, desc = "Git: Blame line" },
  { "<leader>GhB", function()
    if pcall(require, "gitsigns") then
      require("gitsigns").toggle_current_line_blame()
    end
  end, desc = "Git: Toggle blame" },

  -- Git Telescope
  { "<leader>gts", "<cmd>Telescope git_status<CR>", desc = "Git Status" },
  { "<leader>gtc", "<cmd>Telescope git_commits<CR>", desc = "Git Commits" },
  { "<leader>gtb", "<cmd>Telescope git_branches<CR>", desc = "Git Branches" },

  -- Goto
  { "<leader>g", group = "+jump" },
  { "<leader>gd", "<cmd>Telescope lsp_definitions<CR>", desc = "Definition" },
  { "<leader>gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", desc = "Declaration" },
  { "<leader>gi", "<cmd>Telescope lsp_implementations<CR>", desc = "Implementation" },
  { "<leader>gr", "<cmd>Telescope lsp_references<CR>", desc = "References" },

  -- LSP
  { "<leader>l", group = "+lsp" },
  { "<leader>K", "<cmd>lua vim.lsp.buf.hover()<CR>", desc = "LSP hover" },

  -- Trouble
  { "<leader>x", group = "+trouble" },
  { "<leader>xx", "<cmd>Trouble diagnostics toggle<CR>", desc = "Toggle" },
  { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<CR>", desc = "Buffer Diagnostics" },
  { "<leader>xd", "<cmd>TroubleToggle document_diagnostics<CR>", desc = "Document Diagnostics" },
  { "<leader>xq", "<cmd>Trouble qflist toggle<CR>", desc = "Quickfix" },
  { "<leader>xL", "<cmd>Trouble loclist toggle<CR>", desc = "Loclist" },

  -- Corrections d'affichage
  { "<leader>r", group = "+redraw" },
  { "<leader>rr", "<cmd>redraw!<cr>", desc = "Force Redraw complet" },
  { "<leader>rf", "<cmd>mode<cr>", desc = "Rafraîchir le mode" },
  { "<leader>rc", "<cmd>redraw<cr>", desc = "Redraw simple" },
})

-- Mappings spéciaux pour les corrections d'affichage en mode insertion
map("i", "<C-l>", "<Esc><cmd>redraw<cr>a", { desc = "Redraw en insertion", silent = true })

-- Disable continuations
vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    vim.opt.formatoptions:remove({ "c", "r", "o" })
  end,
})
