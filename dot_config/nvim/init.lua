-- Neovim Configuration
-- Enhanced version with better organization and additional features

-- ============================================================================
-- BASIC SETTINGS
-- ============================================================================

-- UI Settings
vim.opt.number = true              -- Show line numbers
vim.opt.relativenumber = true      -- Relative line numbers
vim.opt.termguicolors = true       -- Enable true color
vim.opt.wrap = false               -- Disable line wrap
vim.opt.scrolloff = 8              -- Keep cursor 8 lines from screen edge
vim.opt.signcolumn = "yes"         -- Always show sign column
vim.opt.cursorline = true          -- Highlight current line
vim.opt.cursorcolumn = false       -- Don't highlight current column
vim.opt.showmatch = true           -- Show matching brackets
vim.opt.matchtime = 2              -- How long to show matching brackets
vim.opt.list = false               -- Don't show invisible characters
vim.opt.listchars = { tab = "→ ", trail = "·" }  -- What to show when list is on

-- Indentation and Tabs
vim.opt.expandtab = true           -- Use spaces instead of tabs
vim.opt.shiftwidth = 4             -- Shift 4 spaces when tab
vim.opt.tabstop = 4                -- 1 tab == 4 spaces
vim.opt.softtabstop = 4            -- Backspace deletes 4 spaces
vim.opt.smartindent = true         -- Autoindent new lines
vim.opt.autoindent = true          -- Copy indent from previous line

-- Search Settings
vim.opt.ignorecase = true          -- Ignore case in search
vim.opt.smartcase = true           -- Don't ignore case if search contains uppercase
vim.opt.incsearch = true           -- Incremental search
vim.opt.hlsearch = true            -- Highlight search results

-- Performance
vim.opt.updatetime = 300           -- Faster completion
vim.opt.timeoutlen = 300           -- Timeout for key sequences
vim.opt.lazyredraw = true          -- Don't redraw while executing macros

-- File Handling
vim.opt.backup = false             -- Don't create backup files
vim.opt.swapfile = false           -- Don't create swap files
vim.opt.undofile = true            -- Persistent undo
vim.opt.undodir = vim.fn.stdpath("data") .. "/undo"  -- Undo directory
vim.opt.writebackup = false        -- Don't create backup before writing

-- ============================================================================
-- KEYMAPS
-- ============================================================================

-- Set leader key
vim.g.mapleader = " "

-- General keymaps
vim.keymap.set("n", "<leader>w", ":w<CR>", { desc = "Save file" })
vim.keymap.set("n", "<leader>q", ":q<CR>", { desc = "Quit" })
vim.keymap.set("n", "<leader>Q", ":q!<CR>", { desc = "Force quit" })
vim.keymap.set("n", "<leader>wq", ":wq<CR>", { desc = "Save and quit" })

-- Navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to bottom window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to top window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

-- Buffer navigation
vim.keymap.set("n", "<leader>bn", ":bn<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>bp", ":bp<CR>", { desc = "Previous buffer" })
vim.keymap.set("n", "<leader>bd", ":bd<CR>", { desc = "Delete buffer" })

-- Search and replace
vim.keymap.set("n", "<leader>s", ":%s/", { desc = "Search and replace" })
vim.keymap.set("n", "n", "nzzzv", { desc = "Center next search result" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Center previous search result" })

-- Copy and paste
vim.keymap.set("v", "<leader>y", '"+y', { desc = "Copy to system clipboard" })
vim.keymap.set("n", "<leader>Y", '"+yg_', { desc = "Copy line to system clipboard" })
vim.keymap.set("n", "<leader>y", '"+y', { desc = "Copy to system clipboard" })
vim.keymap.set("n", "<leader>p", '"+p', { desc = "Paste from system clipboard" })
vim.keymap.set("n", "<leader>P", '"+P', { desc = "Paste from system clipboard" })

-- Plugin-specific keymaps
-- Telescope (fuzzy finder)
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Live grep" })
vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Find buffers" })
vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Help tags" })
vim.keymap.set("n", "<leader>fo", "<cmd>Telescope oldfiles<cr>", { desc = "Recent files" })

-- Nvim-tree (file explorer)
vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", { desc = "Toggle file explorer" })
vim.keymap.set("n", "<leader>ef", "<cmd>NvimTreeFocus<cr>", { desc = "Focus file explorer" })

-- Python-specific keymaps
vim.keymap.set("n", "<leader>vd", "<cmd>VenvSelect<cr>", { desc = "Select Python venv" })
vim.keymap.set("n", "<leader>ng", "<cmd>Neogen<cr>", { desc = "Generate docstring" })

-- Testing
vim.keymap.set("n", "<leader>tt", "<cmd>Neotest run<cr>", { desc = "Run tests" })
vim.keymap.set("n", "<leader>tf", "<cmd>Neotest run file<cr>", { desc = "Run tests in file" })
vim.keymap.set("n", "<leader>to", "<cmd>Neotest output<cr>", { desc = "Test output" })

-- Terminal
vim.keymap.set("n", "<leader>t", "<cmd>ToggleTerm<cr>", { desc = "Toggle terminal" })
vim.keymap.set("t", "<esc>", "<cmd>ToggleTerm<cr>", { desc = "Exit terminal" })

-- Search and replace
vim.keymap.set("n", "<leader>sr", "<cmd>Spectre<cr>", { desc = "Search and replace" })

-- Window management
vim.keymap.set("n", "<leader>w=", "<cmd>WindowsMaximize<cr>", { desc = "Maximize window" })
vim.keymap.set("n", "<leader>w-", "<cmd>WindowsMaximizeVertically<cr>", { desc = "Maximize vertically" })
vim.keymap.set("n", "<leader>w|", "<cmd>WindowsMaximizeHorizontally<cr>", { desc = "Maximize horizontally" })

-- ============================================================================
-- AUTOCMDS
-- ============================================================================

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
    pattern = "*",
    callback = function() vim.highlight.on_yank() end
})

-- Create undo directory if it doesn't exist
vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        local undo_dir = vim.fn.stdpath("data") .. "/undo"
        if vim.fn.isdirectory(undo_dir) == 0 then
            vim.fn.mkdir(undo_dir, "p")
        end
    end
})

-- Filetype-specific settings
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "python", "javascript", "typescript", "lua" },
    callback = function()
        vim.opt_local.shiftwidth = 4
        vim.opt_local.tabstop = 4
        vim.opt_local.softtabstop = 4
    end
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "markdown", "text" },
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.linebreak = true
        vim.opt_local.textwidth = 80
    end
})

-- ============================================================================
-- PLUGIN MANAGEMENT WITH LAZY.NVIM
-- ============================================================================

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Plugin specifications
require("lazy").setup({
  -- ============================================================================
  -- ESSENTIAL PLUGINS
  -- ============================================================================

  -- Plugin Manager
  {
    "folke/lazy.nvim",
    version = "*",
  },

  -- Colorscheme
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      vim.cmd.colorscheme "catppuccin"
    end,
  },

  -- Statusline
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          theme = "catppuccin",
          component_separators = { left = "|", right = "|" },
          section_separators = { left = "", right = "" },
        },
      })
    end,
  },

  -- File Explorer
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup({
        sort_by = "case_sensitive",
        view = {
          width = 30,
        },
        renderer = {
          group_empty = true,
        },
        filters = {
          dotfiles = false,
        },
      })
    end,
  },

  -- Fuzzy Finder
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").setup({
        defaults = {
          mappings = {
            i = {
              ["<C-u>"] = false,
              ["<C-d>"] = false,
            },
          },
        },
      })
    end,
  },

  -- Syntax Highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
                ensure_installed = {
          "lua", "vim", "vimdoc", "python", "bash", "javascript",
          "typescript", "json", "yaml", "markdown", "html", "css", "scss",
          "rust", "go", "c", "cpp", "java", "kotlin", "php", "ruby"
        },
        highlight = { enable = true },
        indent = { enable = true },
        incremental_selection = { enable = true },
        textobjects = { enable = true },
      })
    end,
  },

  -- LSP Support
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/nvim-cmp",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
    },
  },

  -- Completion
  {
    "hrsh7th/nvim-cmp",
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = {
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
          ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
          ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
          ["<C-y>"] = cmp.config.disable,
          ["<C-e>"] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
          }),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        },
        sources = {
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        },
      })

      cmp.setup.cmdline("/", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },
      })

      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          { name = "cmdline" },
        }),
      })
    end,
  },

  -- Snippets
  {
    "L3MON4D3/LuaSnip",
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  },

  -- Git Integration
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
    end,
  },

  -- Keymap Help
  {
    "folke/which-key.nvim",
    config = function()
      require("which-key").setup()
    end,
  },

  -- Indent Guides
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    config = function()
      require("ibl").setup()
    end,
  },

  -- ============================================================================
  -- PYTHON DEVELOPMENT PLUGINS
  -- ============================================================================

    -- Python LSP
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")

      -- Python LSP setup
      lspconfig.pyright.setup({
        settings = {
          python = {
            analysis = {
              typeCheckingMode = "basic",
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
              diagnosticMode = "workspace",
            },
          },
        },
      })

      -- Python formatting and linting (updated to use ruff instead of ruff_lsp)
      lspconfig.ruff.setup({
        init_options = {
          settings = {
            args = {},
          },
        },
      })
    end,
  },

  -- Python virtual environments (updated to 2024 version)
  {
    "linux-cultist/venv-selector.nvim",
    branch = "regexp",
    dependencies = {
        "neovim/nvim-lspconfig",
        "nvim-telescope/telescope.nvim",
        "mfussenegger/nvim-dap-python",
    },
    config = function()
      require("venv-selector").setup({
        name = {
          "venv",
          ".venv",
          "env",
          ".env",
        },
        -- Add user-defined search patterns for better venv detection
        search_venv_manager = {
          "poetry",
          "pipenv",
          "virtualenv",
          "conda",
          "pip",
        },
      })
    end,
  },

  -- Python docstring generation
  {
    "danymat/neogen",
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = function()
      require("neogen").setup({
        snippet_engine = "luasnip",
      })
    end,
  },

  -- Python testing
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-neotest/neotest-python",
    },
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-python"),
        },
      })
    end,
  },

  -- ============================================================================
  -- ZSH DEVELOPMENT PLUGINS
  -- ============================================================================

  -- ZSH syntax highlighting (better than treesitter for zsh)
  {
    "arzg/vim-sh",
    ft = { "sh", "zsh", "bash" },
  },

  -- Nginx configuration support
  {
    "chr4/nginx.vim",
    ft = "nginx",
  },

  -- Additional shell script support
  {
    "vim-scripts/bash-support.vim",
    ft = { "sh", "bash", "zsh" },
  },

  -- ============================================================================
  -- ADDITIONAL DEVELOPMENT PLUGINS
  -- ============================================================================

  -- Comment out/in lines
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
  },

  -- Surround text with brackets, quotes, etc.
  {
    "kylechui/nvim-surround",
    version = "*",
    config = function()
      require("nvim-surround").setup()
    end,
  },

  -- Auto-pair brackets and quotes
  {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup()
    end,
  },

  -- Better terminal integration
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup({
        size = 20,
        open_mapping = [[<c-\>]],
        hide_numbers = true,
        shade_filetypes = {},
        shade_terminals = true,
        shading_factor = 2,
        start_in_insert = true,
        insert_mappings = true,
        persist_size = true,
        direction = "float",
        close_on_exit = true,
        shell = vim.o.shell,
        float_opts = {
          border = "curved",
          winblend = 0,
          highlights = {
            border = "Normal",
            background = "Normal",
          },
        },
      })
    end,
  },

  -- Better search and replace
  {
    "nvim-pack/nvim-spectre",
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  -- Better quickfix
  {
    "kevinhwang91/nvim-bqf",
    ft = "qf",
  },

  -- Better buffer management
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      require("bufferline").setup({
        options = {
          mode = "buffers",
          separator_style = "slant",
          always_show_bufferline = false,
          show_buffer_close_icons = true,
          show_close_icon = false,
          color_icons = true,
        },
      })
    end,
  },

  -- Better notifications
  {
    "rcarriga/nvim-notify",
    config = function()
      vim.notify = require("notify")
    end,
  },

  -- Better search highlighting
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      {
        "s",
        mode = { "n", "x", "o" },
        function()
          require("flash").jump()
        end,
        desc = "Flash",
      },
      {
        "S",
        mode = { "n", "o", "x" },
        function()
          require("flash").treesitter()
        end,
        desc = "Flash Treesitter",
      },
    },
  },

  -- Better window management
  {
    "anuvyklack/windows.nvim",
    dependencies = {
      "anuvyklack/middleclass",
      "anuvyklack/animation.nvim",
    },
    config = function()
      vim.o.winwidth = 10
      vim.o.winminwidth = 10
      vim.o.equalalways = false
      require("windows").setup()
    end,
  },

  -- Better project management
  {
    "ahmedkhalf/project.nvim",
    config = function()
      require("project_nvim").setup({
        detection_methods = { "lsp", "pattern" },
        patterns = { ".git", "Makefile", "package.json", "pyproject.toml" },
      })
    end,
  },
})

-- ============================================================================
-- ADDITIONAL SETTINGS
-- ============================================================================

-- Disable some built-in plugins
local disabled_built_ins = {
    "netrw",
    "netrwPlugin",
    "netrwSettings",
    "netrwFileHandlers",
    "gzip",
    "zip",
    "zipPlugin",
    "tar",
    "tarPlugin",
    "getscript",
    "getscriptPlugin",
    "vimball",
    "vimballPlugin",
    "2html_plugin",
    "logipat",
    "rrhelper",
    "spellfile_plugin",
    "matchit"
}

for _, plugin in pairs(disabled_built_ins) do
    vim.g["loaded_" .. plugin] = 1
end

-- Set colorscheme (uncomment and install a colorscheme plugin)
-- vim.cmd("colorscheme tokyonight")
-- vim.cmd("colorscheme catppuccin")
-- vim.cmd("colorscheme gruvbox")

print("Neovim configuration loaded successfully!")
