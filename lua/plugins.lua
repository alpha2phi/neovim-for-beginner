local M = {}

function M.setup()
  -- Indicate first time installation
  local packer_bootstrap = false

  -- packer.nvim configuration
  local conf = {
    profile = {
      enable = true,
      threshold = 0, -- the amount in ms that a plugins load time must be over for it to be included in the profile
    },

    display = {
      open_fn = function()
        return require("packer.util").float { border = "rounded" }
      end,
    },
  }

  -- Check if packer.nvim is installed
  -- Run PackerCompile if there are changes in this file
  local function packer_init()
    local fn = vim.fn
    local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then
      packer_bootstrap = fn.system {
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
      }
      vim.cmd [[packadd packer.nvim]]
    end
    vim.cmd "autocmd BufWritePost plugins.lua source <afile> | PackerCompile"
  end

  -- Plugins
  local function plugins(use)
    use { "wbthomason/packer.nvim" }

    -- Performance
    use { "lewis6991/impatient.nvim" }

    -- Load only when require
    use { "nvim-lua/plenary.nvim", module = "plenary" }

    -- Notification
    use {
      "rcarriga/nvim-notify",
      event = "VimEnter",
      config = function()
        require("config.notify").setup()
      end,
    }

    -- Colorscheme
    use {
      "folke/tokyonight.nvim",
      config = function()
        vim.cmd "colorscheme tokyonight"
      end,
      disable = true,
    }
    use {
      "sainnhe/everforest",
      config = function()
        vim.g.everforest_better_performance = 1
        vim.cmd "colorscheme everforest"
      end,
      disable = false,
    }
    use {
      "sainnhe/gruvbox-material",
      config = function()
        vim.cmd "colorscheme gruvbox-material"
      end,
      disable = true,
    }
    use {
      "arcticicestudio/nord-vim",
      config = function()
        vim.cmd "colorscheme nord"
      end,
      disable = true,
    }
    use {
      "norcalli/nvim-colorizer.lua",
      cmd = "ColorizerToggle",
      config = function()
        require("colorizer").setup()
      end,
    }

    -- Startup screen
    use {
      "goolord/alpha-nvim",
      config = function()
        require("config.alpha").setup()
      end,
    }

    -- Doc
    use { "nanotee/luv-vimdocs", event = "BufReadPre" }
    use { "milisims/nvim-luaref", event = "BufReadPre" }

    -- Better Netrw
    use { "tpope/vim-vinegar" }

    -- Git
    use {
      "TimUntersberger/neogit",
      cmd = "Neogit",
      config = function()
        require("config.neogit").setup()
      end,
    }
    use {
      "lewis6991/gitsigns.nvim",
      event = "BufReadPre",
      wants = "plenary.nvim",
      requires = { "nvim-lua/plenary.nvim" },
      config = function()
        require("config.gitsigns").setup()
      end,
    }
    use {
      "tpope/vim-fugitive",
      cmd = { "Git", "GBrowse", "Gdiffsplit", "Gvdiffsplit" },
      requires = { "tpope/vim-rhubarb" },
      -- wants = { "vim-rhubarb" },
    }
    use {
      "ruifm/gitlinker.nvim",
      requires = "nvim-lua/plenary.nvim",
      module = "gitlinker",
      config = function()
        require("gitlinker").setup { mappings = nil }
      end,
    }
    use {
      "pwntester/octo.nvim",
      cmd = "Octo",
      wants = { "telescope.nvim", "plenary.nvim", "nvim-web-devicons" },
      requires = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim",
        "kyazdani42/nvim-web-devicons",
      },
      config = function()
        require("octo").setup()
      end,
      disable = true,
    }

    -- WhichKey
    use {
      "folke/which-key.nvim",
      event = "VimEnter",
      config = function()
        require("config.whichkey").setup()
      end,
    }

    -- IndentLine
    use {
      "lukas-reineke/indent-blankline.nvim",
      event = "BufReadPre",
      config = function()
        require("config.indentblankline").setup()
      end,
    }

    -- Better icons
    use {
      "kyazdani42/nvim-web-devicons",
      module = "nvim-web-devicons",
      config = function()
        require("nvim-web-devicons").setup { default = true }
      end,
    }

    -- Better Comment
    use {
      "numToStr/Comment.nvim",
      keys = { "gc", "gcc", "gbc" },
      config = function()
        require("config.comment").setup()
      end,
    }

    -- Better surround
    use { "tpope/vim-surround", event = "InsertEnter" }

    -- Motions
    use { "andymass/vim-matchup", event = "CursorMoved" }
    use { "wellle/targets.vim", event = "CursorMoved" }
    use { "unblevable/quick-scope", event = "CursorMoved", disable = false }
    use { "chaoren/vim-wordmotion", opt = true, fn = { "<Plug>WordMotion_w" } }

    -- Buffer
    use { "kazhala/close-buffers.nvim", cmd = { "BDelete", "BWipeout" } }
    use {
      "matbme/JABS.nvim",
      cmd = "JABSOpen",
      config = function()
        require("config.jabs").setup()
      end,
      disable = false,
    }
    use {
      "chentoast/marks.nvim",
      event = "BufReadPre",
      config = function()
        require("marks").setup {}
      end,
    }

    -- IDE
    use {
      "antoinemadec/FixCursorHold.nvim",
      event = "BufReadPre",
      config = function()
        vim.g.cursorhold_updatetime = 100
      end,
    }
    use {
      "max397574/better-escape.nvim",
      event = { "InsertEnter" },
      config = function()
        require("better_escape").setup {
          mapping = { "jk" },
          timeout = vim.o.timeoutlen,
          keys = "<ESC>",
        }
      end,
    }
    use {
      "karb94/neoscroll.nvim",
      event = "BufReadPre",
      config = function()
        require("config.neoscroll").setup()
      end,
      disable = true,
    }
    use { "google/vim-searchindex", event = "BufReadPre" }
    use { "tyru/open-browser.vim", event = "BufReadPre" }

    -- Code documentation
    use {
      "danymat/neogen",
      config = function()
        require("config.neogen").setup()
      end,
      cmd = { "Neogen" },
      module = "neogen",
      disable = false,
    }

    use {
      "kkoomen/vim-doge",
      run = ":call doge#install()",
      config = function()
        require("config.doge").setup()
      end,
      cmd = { "DogeGenerate", "DogeCreateDocStandard" },
      disable = false,
    }

    -- use {
    --   "kkoomen/vim-doge",
    --   run = ":call doge#install()",
    --   config = function()
    --     require("config.doge").setup()
    --   end,
    --   event = "VimEnter",
    -- }

    use {
      "phaazon/hop.nvim",
      cmd = { "HopWord", "HopChar1" },
      config = function()
        require("hop").setup {}
      end,
      disable = true,
    }
    use {
      "ggandor/leap.nvim",
      keys = { "s", "S", "f", "F", "t", "T" },
      config = function()
        local leap = require "leap"
        leap.set_default_keymaps()
      end,
    }
    -- use {
    --   "ggandor/lightspeed.nvim",
    --   keys = { "s", "S", "f", "F", "t", "T" },
    --   config = function()
    --     require("lightspeed").setup {}
    --   end,
    -- }

    -- Markdown
    use {
      "iamcco/markdown-preview.nvim",
      opt = true,
      run = function()
        vim.fn["mkdp#util#install"]()
      end,
      ft = "markdown",
      cmd = { "MarkdownPreview" },
      requires = { "zhaozg/vim-diagram", "aklt/plantuml-syntax" },
    }
    use {
      "jakewvincent/mkdnflow.nvim",
      config = function()
        require("mkdnflow").setup {}
      end,
      ft = "markdown",
    }
    use {
      "nvim-neorg/neorg",
      config = function()
        require("neorg").setup {
          load = {
            ["core.defaults"] = {},
            ["core.presenter"] = {
              config = {
                zen_mode = "truezen",
              },
            },
          },
        }
      end,
      ft = "norg",
      after = "nvim-treesitter",
      requires = { "nvim-lua/plenary.nvim", "Pocco81/TrueZen.nvim" },
      disable = true,
    }

    -- Status line
    use {
      "nvim-lualine/lualine.nvim",
      event = "VimEnter",
      after = "nvim-treesitter",
      config = function()
        require("config.lualine").setup()
      end,
      wants = "nvim-web-devicons",
    }
    use {
      "SmiteshP/nvim-gps",
      requires = "nvim-treesitter/nvim-treesitter",
      module = "nvim-gps",
      wants = "nvim-treesitter",
      config = function()
        require("nvim-gps").setup()
      end,
    }
    use {
      "b0o/incline.nvim",
      event = "BufReadPre",
      config = function()
        require("incline").setup()
      end,
      disable = true,
    }

    -- Treesitter
    use {
      "nvim-treesitter/nvim-treesitter",
      opt = true,
      event = "BufReadPre",
      run = ":TSUpdate",
      config = function()
        require("config.treesitter").setup()
      end,
      requires = {
        { "nvim-treesitter/nvim-treesitter-textobjects", event = "BufReadPre" },
        { "windwp/nvim-ts-autotag", event = "InsertEnter" },
        { "JoosepAlviste/nvim-ts-context-commentstring", event = "BufReadPre" },
        { "nvim-treesitter/nvim-treesitter-context", event = "BufReadPre" },
        { "p00f/nvim-ts-rainbow", event = "BufReadPre" },
      },
    }

    if PLUGINS.fzf_lua.enabled then
      -- FZF
      use { "junegunn/fzf", run = "./install --all", event = "VimEnter", disable = true } -- You don't need to install this if you already have fzf installed
      use { "junegunn/fzf.vim", event = "BufEnter", disable = true }

      -- FZF Lua
      use {
        "ibhagwan/fzf-lua",
        event = "BufEnter",
        wants = "nvim-web-devicons",
        requires = { "junegunn/fzf", run = "./install --all" },
      }
    end

    if PLUGINS.telescope.enabled then
      use {
        "nvim-telescope/telescope.nvim",
        opt = true,
        config = function()
          require("config.telescope").setup()
        end,
        cmd = { "Telescope" },
        module = { "telescope", "telescope.builtin" },
        keys = { "<leader>f", "<leader>p", "<leader>z" },
        wants = {
          "plenary.nvim",
          "popup.nvim",
          "telescope-fzf-native.nvim",
          "telescope-project.nvim",
          "telescope-repo.nvim",
          "telescope-file-browser.nvim",
          "project.nvim",
          -- "vim-rooter",
          "trouble.nvim",
          "telescope-dap.nvim",
          "telescope-frecency.nvim",
          "nvim-neoclip.lua",
          "telescope-smart-history.nvim",
          "telescope-arecibo.nvim",
          "telescope-media-files.nvim",
        },
        requires = {
          "nvim-lua/popup.nvim",
          "nvim-lua/plenary.nvim",
          { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
          "nvim-telescope/telescope-project.nvim",
          "cljoly/telescope-repo.nvim",
          "nvim-telescope/telescope-file-browser.nvim",
          { "nvim-telescope/telescope-frecency.nvim", requires = "tami5/sqlite.lua" },
          -- {
          --   "airblade/vim-rooter",
          --   config = function()
          --     require("config.rooter").setup()
          --   end,
          -- },
          {
            "ahmedkhalf/project.nvim",
            config = function()
              require("config.project").setup()
            end,
          },
          "nvim-telescope/telescope-dap.nvim",
          {
            "AckslD/nvim-neoclip.lua",
            requires = {
              { "tami5/sqlite.lua", module = "sqlite" },
              -- config = function()
              --   require("neoclip").setup()
              -- end,
            },
          },
          "nvim-telescope/telescope-smart-history.nvim",
          {
            "nvim-telescope/telescope-arecibo.nvim",
            rocks = { "openssl", "lua-http-parser" },
          },
          "nvim-telescope/telescope-media-files.nvim",
          "dhruvmanila/telescope-bookmarks.nvim",
        },
      }
    end

    -- nvim-tree
    use {
      "kyazdani42/nvim-tree.lua",
      opt = true,
      wants = "nvim-web-devicons",
      cmd = { "NvimTreeToggle", "NvimTreeClose" },
      module = "nvim-tree",
      config = function()
        require("config.nvimtree").setup()
      end,
    }

    -- Buffer line
    use {
      "akinsho/nvim-bufferline.lua",
      event = "BufReadPre",
      wants = "nvim-web-devicons",
      config = function()
        require("config.bufferline").setup()
      end,
    }

    -- User interface
    use {
      "stevearc/dressing.nvim",
      event = "BufReadPre",
      config = function()
        require("dressing").setup {
          input = { relative = "editor" },
          select = {
            backend = { "telescope", "fzf", "builtin" },
          },
        }
      end,
      disable = false,
    }

    -- Completion
    use {
      "ms-jpq/coq_nvim",
      branch = "coq",
      event = "VimEnter",
      opt = true,
      run = ":COQdeps",
      config = function()
        require("config.coq").setup()
      end,
      requires = {
        { "ms-jpq/coq.artifacts", branch = "artifacts" },
        { "ms-jpq/coq.thirdparty", branch = "3p", module = "coq_3p" },
      },
      disable = not PLUGINS.coq.enabled,
    }

    use {
      "hrsh7th/nvim-cmp",
      event = "InsertEnter",
      opt = true,
      config = function()
        require("config.cmp").setup()
      end,
      wants = { "LuaSnip" },
      requires = {
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-nvim-lua",
        "ray-x/cmp-treesitter",
        "hrsh7th/cmp-cmdline",
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-nvim-lsp-signature-help",
        -- "onsails/lspkind-nvim",
        -- "hrsh7th/cmp-calc",
        -- "f3fora/cmp-spell",
        -- "hrsh7th/cmp-emoji",
        {
          "L3MON4D3/LuaSnip",
          wants = { "friendly-snippets", "vim-snippets" },
          config = function()
            require("config.snip").setup()
          end,
        },
        "rafamadriz/friendly-snippets",
        "honza/vim-snippets",
      },
      disable = not PLUGINS.nvim_cmp.enabled,
    }

    -- Auto pairs
    use {
      "windwp/nvim-autopairs",
      opt = true,
      event = "InsertEnter",
      wants = "nvim-treesitter",
      module = { "nvim-autopairs.completion.cmp", "nvim-autopairs" },
      config = function()
        require("config.autopairs").setup()
      end,
    }

    -- Auto tag
    use {
      "windwp/nvim-ts-autotag",
      opt = true,
      wants = "nvim-treesitter",
      event = "InsertEnter",
      config = function()
        require("nvim-ts-autotag").setup { enable = true }
      end,
    }

    -- End wise
    use {
      "RRethy/nvim-treesitter-endwise",
      opt = true,
      wants = "nvim-treesitter",
      event = "InsertEnter",
      disable = false,
    }

    -- LSP
    if PLUGINS.nvim_cmp.enabled then
      use {
        "neovim/nvim-lspconfig",
        opt = true,
        event = "VimEnter",
        -- event = { "BufReadPre" },
        -- keys = { "<leader>l", "<leader>f" },
        -- wants = { "nvim-lsp-installer", "lsp_signature.nvim", "cmp-nvim-lsp" },
        wants = {
          "nvim-lsp-installer",
          "cmp-nvim-lsp",
          "lua-dev.nvim",
          "vim-illuminate",
          "null-ls.nvim",
          "schemastore.nvim",
          -- "nvim-lsp-ts-utils",
          "typescript.nvim",
        },
        config = function()
          require("config.lsp").setup()
        end,
        requires = {
          "williamboman/nvim-lsp-installer",
          "folke/lua-dev.nvim",
          "RRethy/vim-illuminate",
          "jose-elias-alvarez/null-ls.nvim",
          {
            "j-hui/fidget.nvim",
            config = function()
              require("fidget").setup {}
            end,
          },
          "b0o/schemastore.nvim",
          -- "jose-elias-alvarez/nvim-lsp-ts-utils",
          "jose-elias-alvarez/typescript.nvim",
          -- "ray-x/lsp_signature.nvim",
        },
      }
    end

    if PLUGINS.coq.enabled then
      use {
        "neovim/nvim-lspconfig",
        opt = true,
        -- event = "VimEnter",
        event = { "BufReadPre" },
        wants = {
          "nvim-lsp-installer",
          "lsp_signature.nvim",
          "coq_nvim",
          "lua-dev.nvim",
          "vim-illuminate",
          "null-ls.nvim",
          "schemastore.nvim",
          -- "nvim-lsp-ts-utils",
          "typescript.nvim",
        }, -- for coq.nvim
        config = function()
          require("config.lsp").setup()
        end,
        requires = {
          "williamboman/nvim-lsp-installer",
          "ray-x/lsp_signature.nvim",
          "folke/lua-dev.nvim",
          "RRethy/vim-illuminate",
          "jose-elias-alvarez/null-ls.nvim",
          {
            "j-hui/fidget.nvim",
            config = function()
              require("fidget").setup {}
            end,
          },
          "b0o/schemastore.nvim",
          -- "jose-elias-alvarez/nvim-lsp-ts-utils",
          "jose-elias-alvarez/typescript.nvim",
        },
      }
    end

    -- trouble.nvim
    use {
      "folke/trouble.nvim",
      wants = "nvim-web-devicons",
      cmd = { "TroubleToggle", "Trouble" },
      config = function()
        require("trouble").setup {
          use_diagnostic_signs = true,
        }
      end,
    }

    -- lspsaga.nvim
    use {
      "tami5/lspsaga.nvim",
      cmd = { "Lspsaga" },
      config = function()
        require("lspsaga").setup {}
      end,
    }

    -- renamer.nvim
    use {
      "filipdutescu/renamer.nvim",
      module = { "renamer" },
      config = function()
        require("renamer").setup {}
      end,
    }

    -- Rust
    use {
      "simrat39/rust-tools.nvim",
      requires = { "nvim-lua/plenary.nvim", "rust-lang/rust.vim" },
      opt = true,
      module = "rust-tools",
      ft = { "rust" },
      config = function()
        require("config.rust").setup()
      end,
    }
    use {
      "saecki/crates.nvim",
      event = { "BufRead Cargo.toml" },
      requires = { { "nvim-lua/plenary.nvim" } },
      config = function()
        -- local null_ls = require "null-ls"
        require("crates").setup {
          null_ls = {
            enabled = true,
            name = "crates.nvim",
          },
        }
      end,
    }

    -- Go
    use {
      "ray-x/go.nvim",
      ft = { "go" },
      config = function()
        require("go").setup()
      end,
    }

    -- Terminal
    use {
      "akinsho/toggleterm.nvim",
      keys = { [[<C-\>]] },
      cmd = { "ToggleTerm", "TermExec" },
      config = function()
        require("config.toggleterm").setup()
      end,
    }

    -- Debugging
    use {
      "mfussenegger/nvim-dap",
      opt = true,
      -- event = "BufReadPre",
      keys = { [[<leader>d]] },
      module = { "dap" },
      wants = { "nvim-dap-virtual-text", "DAPInstall.nvim", "nvim-dap-ui", "nvim-dap-python", "which-key.nvim" },
      requires = {
        "alpha2phi/DAPInstall.nvim",
        -- { "Pocco81/dap-buddy.nvim", branch = "dev" },
        "theHamsta/nvim-dap-virtual-text",
        "rcarriga/nvim-dap-ui",
        "mfussenegger/nvim-dap-python",
        "nvim-telescope/telescope-dap.nvim",
        { "leoluz/nvim-dap-go", module = "dap-go" },
        { "jbyuki/one-small-step-for-vimkind", module = "osv" },
      },
      config = function()
        require("config.dap").setup()
      end,
      disable = not PLUGINS.nvim_dap,
    }

    -- vimspector
    use {
      "puremourning/vimspector",
      cmd = { "VimspectorInstall", "VimspectorUpdate" },
      fn = { "vimspector#Launch()", "vimspector#ToggleBreakpoint", "vimspector#Continue" },
      config = function()
        require("config.vimspector").setup()
      end,
    }

    -- Test
    use {
      "rcarriga/vim-ultest",
      requires = { "vim-test/vim-test" },
      opt = true,
      keys = { "<leader>t" },
      cmd = {
        "TestNearest",
        "TestFile",
        "TestSuite",
        "TestLast",
        "TestVisit",
        "Ultest",
        "UltestNearest",
        "UltestDebug",
        "UltestLast",
        "UltestSummary",
      },
      module = "ultest",
      run = ":UpdateRemotePlugins",
      config = function()
        require("config.test").setup()
      end,
    }

    -- AI completion
    use { "github/copilot.vim", event = "InsertEnter" }

    -- Legendary
    use {
      "mrjones2014/legendary.nvim",
      opt = true,
      keys = { [[<C-p>]] },
      wants = { "dressing.nvim" },
      config = function()
        require("config.legendary").setup()
      end,
      requires = { "stevearc/dressing.nvim" },
    }

    -- Harpoon
    use {
      "ThePrimeagen/harpoon",
      keys = { [[<leader>j]] },
      module = { "harpoon", "harpoon.cmd-ui", "harpoon.mark", "harpoon.ui", "harpoon.term" },
      wants = { "telescope.nvim" },
      config = function()
        require("config.harpoon").setup()
      end,
    }

    -- Refactoring
    use {
      "ThePrimeagen/refactoring.nvim",
      module = { "refactoring", "telescope" },
      keys = { [[<leader>r]] },
      wants = { "telescope.nvim" },
      config = function()
        require("config.refactoring").setup()
      end,
    }
    use { "python-rope/ropevim", run = "pip install ropevim", disable = true }
    use {
      "kevinhwang91/nvim-bqf",
      ft = "qf",
      disable = true,
      config = function()
        require("bqf").setup()
      end,
    }
    use { "kevinhwang91/nvim-hlslens", event = "BufReadPre", disable = true }
    use { "nvim-pack/nvim-spectre", module = "spectre", keys = { "<leader>s" } }

    -- Performance
    use { "dstein64/vim-startuptime", cmd = "StartupTime" }
    use { "nathom/filetype.nvim" }

    -- Web
    use {
      "vuki656/package-info.nvim",
      opt = true,
      requires = {
        "MunifTanjim/nui.nvim",
      },
      wants = { "nui.nvim" },
      module = { "package-info" },
      ft = { "json" },
      config = function()
        require("config.package").setup()
      end,
      disable = false,
    }
    use {
      "meain/vim-package-info",
      ft = { "json" },
      run = "npm install",
      disable = true,
    }

    -- Session
    use {
      "rmagatti/auto-session",
      opt = true,
      cmd = { "SaveSession", "RestoreSession" },
      requires = { "rmagatti/session-lens" },
      wants = { "telescope.nvim", "session-lens" },
      config = function()
        require("bad_practices").setup()
      end,
      disable = false,
    }
    use {
      "jedrzejboczar/possession.nvim",
      config = function()
        require("config.possession").setup()
      end,
      cmd = { "PossessionSave", "PosessionLoad", "PosessionShow", "PossessionList" },
      disable = true,
    }
    use {
      "tpope/vim-obsession",
      cmd = { "Obsess" },
      config = function()
        require("config.obsession").setup()
      end,
      disable = true,
    }

    -- Practice
    use {
      "antonk52/bad-practices.nvim",
      event = "BufReadPre",
      config = function()
        require("bad_practices").setup()
      end,
      disable = true,
    }

    -- Plugin
    use {
      "tpope/vim-scriptease",
      cmd = {
        "Messages", --view messages in quickfix list
        "Verbose", -- view verbose output in preview window.
        "Time", -- measure how long it takes to run some stuff.
      },
      event = "BufReadPre",
    }

    -- Quickfix
    use { "romainl/vim-qf", event = "BufReadPre", disable = true }

    -- Todo
    use {
      "folke/todo-comments.nvim",
      config = function()
        require("config.todocomments").setup()
      end,
      cmd = { "TodoQuickfix", "TodoTrouble", "TodoTelescope" },
    }

    -- Diffview
    use {
      "sindrets/diffview.nvim",
      requires = "nvim-lua/plenary.nvim",
      cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles" },
    }

    -- Sidebar
    use {
      "liuchengxu/vista.vim",
      cmd = { "Vista" },
      config = function()
        vim.g.vista_default_executive = "nvim_lsp"
      end,
    }
    use {
      "sidebar-nvim/sidebar.nvim",
      cmd = { "SidebarNvimToggle" },
      config = function()
        require("sidebar-nvim").setup { open = false }
      end,
    }

    -- Translation
    use {
      "voldikss/vim-translator",
      cmd = { "Translate", "TranslateV", "TranslateW", "TranslateWV", "TranslateR", "TranslateRV", "TranslateX" },
      config = function()
        vim.g.translator_target_lang = "zh"
        vim.g.translator_history_enable = true
      end,
    }

    -- REPL
    use {
      "hkupty/iron.nvim",
      config = function()
        require("config.iron").setup()
      end,
      disable = true,
    }

    -- Testing
    use {
      "m-demare/attempt.nvim",
      opt = true,
      requires = "nvim-lua/plenary.nvim",
      module = { "attempt" },
      config = function()
        require("attempt").setup()
      end,
      disable = true,
    }
    use {
      "ziontee113/syntax-tree-surfer",
      opt = true,
      event = "BufReadPre",
      module = { "syntax-tree-surfer" },
      config = function()
        require("config.syntaxtreesurfer").setup()
      end,
      disable = false,
    }
    use {
      "ghillb/cybu.nvim",
      branch = "main",
      event = "BufReadPre",
      config = function()
        require("config.cybu").setup()
      end,
      disable = true,
    }
    use { "tversteeg/registers.nvim", disable = true }
    -- https://github.com/WhoIsSethDaniel/toggle-lsp-diagnostics.nvim
    -- https://github.com/rbong/vim-buffest
    -- https://github.com/jamestthompson3/nvim-remote-containers
    -- https://github.com/esensar/nvim-dev-container

    -- Bootstrap Neovim
    if packer_bootstrap then
      print "Restart Neovim required after installation!"
      require("packer").sync()
    end
  end

  -- Init and start packer
  packer_init()
  local packer = require "packer"

  -- Performance
  pcall(require, "impatient")
  -- pcall(require, "packer_compiled")

  packer.init(conf)
  packer.startup(plugins)
end

return M
