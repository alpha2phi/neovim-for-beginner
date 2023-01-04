local M = {}

function M.setup()
  -- Indicate first time installation
  local is_boostrap = false

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
      fn.system {
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
      }
      is_boostrap = true
      vim.cmd [[packadd packer.nvim]]
    end

    -- Run PackerCompile if there are changes in this file
    -- vim.cmd "autocmd BufWritePost plugins.lua source <afile> | PackerCompile"
    local packer_grp = vim.api.nvim_create_augroup("packer_user_config", { clear = true })
    vim.api.nvim_create_autocmd(
      { "BufWritePost" },
      { pattern = vim.fn.expand "$MYVIMRC", command = "source <afile> | PackerCompile", group = packer_grp }
    )
  end

  -- Plugins
  local function plugins(use)
    use { "wbthomason/packer.nvim" }

    -- Performance
    use { "lewis6991/impatient.nvim" }

    -- Load only when require
    use { "nvim-lua/plenary.nvim", module = "plenary" }

    -- literate programming
    use {
      "~/workspace/alpha2phi/lp.nvim",
      disable = true,
    }

    -- Notification
    use {
      "rcarriga/nvim-notify",
      event = "BufReadPre",
      config = function()
        require("config.notify").setup()
      end,
      disable = false,
    }
    use {
      "simrat39/desktop-notify.nvim",
      config = function()
        require("desktop-notify").override_vim_notify()
      end,
      disable = true,
    }
    use {
      "vigoux/notifier.nvim",
      config = function()
        require("notifier").setup {}
      end,
      disable = true,
    }

    -- Colorscheme
    use {
      "catppuccin/nvim",
      as = "catppuccin",
      config = function()
        vim.g.catppuccin_flavour = "macchiato" -- latte, frappe, macchiato, mocha
        require("catppuccin").setup()
        vim.cmd [[colorscheme catppuccin]]
      end,
      disable = true,
    }

    use {
      "folke/tokyonight.nvim",
      config = function()
        vim.cmd.colorscheme [[tokyonight]]
      end,
      disable = false,
    }
    use {
      "sainnhe/everforest",
      config = function()
        vim.g.everforest_better_performance = 1
        vim.cmd.colorscheme [[everforest]]
      end,
      disable = true,
    }
    use {
      "projekt0n/github-nvim-theme",
      disable = true,
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
      "nvchad/nvim-colorizer.lua",
      cmd = "ColorizerToggle",
      config = function()
        require("colorizer").setup()
      end,
    }
    use {
      "rktjmp/lush.nvim",
      cmd = { "LushRunQuickstart", "LushRunTutorial", "Lushify", "LushImport" },
      disable = false,
    }
    use {
      "max397574/colortils.nvim",
      cmd = "Colortils",
      config = function()
        require("colortils").setup()
      end,
    }
    use {
      "ziontee113/color-picker.nvim",
      cmd = { "PickColor", "PickColorInsert" },
      config = function()
        require "color-picker"
      end,
    }
    use {
      "lifepillar/vim-colortemplate",
      disable = true,
    }

    -- Startup screen
    use {
      "goolord/alpha-nvim",
      config = function()
        require("config.alpha").setup()
      end,
    }
    use {
      "folke/drop.nvim",
      event = "VimEnter",
      config = function()
        math.randomseed(os.time())
        local theme = ({ "stars", "snow", "xmas" })[math.random(1, 3)]
        require("drop").setup { theme = theme }
      end,
      disable = true,
    }

    -- Doc
    use { "nanotee/luv-vimdocs", event = "BufReadPre" }
    use { "milisims/nvim-luaref", event = "BufReadPre" }

    -- Better Netrw
    use { "tpope/vim-vinegar", event = "BufReadPre" }

    -- Git
    use {
      "TimUntersberger/neogit",
      cmd = "Neogit",
      module = { "neogit" },
      config = function()
        require("config.neogit").setup()
      end,
    }
    use { "jreybert/vimagit", cmd = "Magit", disable = true }
    use {
      "lewis6991/gitsigns.nvim",
      event = "BufReadPre",
      requires = { "nvim-lua/plenary.nvim" },
      config = function()
        require("config.gitsigns").setup()
      end,
    }
    use {
      "tpope/vim-fugitive",
      opt = true,
      cmd = { "Git", "GBrowse", "Gdiffsplit", "Gvdiffsplit" },
      requires = {
        "tpope/vim-rhubarb",
        "idanarye/vim-merginal",
        --[[ "rhysd/committia.vim", ]]
      },
    }
    use {
      "rbong/vim-flog",
      cmd = { "Flog", "Flogsplit", "Floggit" },
      wants = { "vim-fugitive" },
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
      requires = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim",
        "nvim-tree/nvim-web-devicons",
      },
      config = function()
        require("octo").setup()
      end,
      disable = false,
    }
    use {
      "akinsho/git-conflict.nvim",
      cmd = {
        "GitConflictChooseTheirs",
        "GitConflictChooseOurs",
        "GitConflictChooseBoth",
        "GitConflictChooseNone",
        "GitConflictNextConflict",
        "GitConflictPrevConflict",
        "GitConflictListQf",
      },
      config = function()
        require("git-conflict").setup()
      end,
    }
    use {
      "ldelossa/gh.nvim",
      opt = true,
      requires = { { "ldelossa/litee.nvim" } },
      event = "BufReadPre",
      cmd = { "GHOpenPR" },
      config = function()
        require("litee.lib").setup()
        require("litee.gh").setup()
      end,
      disable = true,
    }
    use { "f-person/git-blame.nvim", cmd = { "GitBlameToggle" } }
    use {
      "tanvirtin/vgit.nvim",
      config = function()
        require("vgit").setup()
      end,
      cmd = { "VGit" },
    }
    use { "knsh14/vim-github-link", cmd = { "GetCommitLink", "GetCurrentBranchLink", "GetCurrentCommitLink" } }
    use { "segeljakt/vim-silicon", cmd = { "Silicon" } }
    use {
      "mattn/vim-gist",
      opt = true,
      requires = { "mattn/webapi-vim" },
      cmd = { "Gist" },
      config = function()
        vim.g.gist_open_browser_after_post = 1
      end,
    }

    -- WhichKey
    use {
      "folke/which-key.nvim",
      event = "VimEnter",
      module = { "which-key" },
      -- keys = { [[<leader>]] },
      config = function()
        require("config.whichkey").setup()
      end,
      disable = false,
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
      "nvim-tree/nvim-web-devicons",
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
      disable = false,
    }
    use { "tpope/vim-commentary", keys = { "gc", "gcc", "gbc" }, disable = true }

    -- Better surround
    use { "tpope/vim-surround", event = "BufReadPre" }
    use {
      "Matt-A-Bennett/vim-surround-funk",
      event = "BufReadPre",
      config = function()
        require("config.surroundfunk").setup()
      end,
      disable = true,
    }

    -- Motions
    use { "andymass/vim-matchup", event = "CursorMoved" }
    use { "wellle/targets.vim", event = "CursorMoved", disable = false }
    use {
      "unblevable/quick-scope",
      keys = { "F", "f", "T", "t" },
      -- config = function()
      --   vim.g.qs_highlight_on_keys = { "f", "F", "t", "T" }
      -- end,
      disable = false,
    }
    use {
      "jinh0/eyeliner.nvim",
      keys = { "F", "f", "T", "t" },
      config = function()
        require("eyeliner").setup {
          highlight_on_key = true,
        }
      end,
      disable = true,
    }
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
    use {
      "bennypowers/nvim-regexplainer",
      config = function()
        require("regexplainer").setup()
      end,
      requires = {
        "nvim-treesitter/nvim-treesitter",
        "MunifTanjim/nui.nvim",
      },
      disable = true,
    }
    use {
      "Djancyp/regex.nvim",
      config = function()
        require("regex-nvim").Setup()
      end,
      disable = true,
    }
    use { "mbbill/undotree", cmd = { "UndotreeToggle" } }
    use {
      "anuvyklack/windows.nvim",
      requires = {
        "anuvyklack/middleclass",
        "anuvyklack/animation.nvim",
      },
      cmd = { "WindowsToggleAutowidth", "WindowsMaximize" },
      config = function()
        vim.o.winwidth = 10
        vim.o.winminwidth = 10
        vim.o.equalalways = false
        require("windows").setup()
      end,
      disable = true,
    }
    use {
      "beauwilliams/focus.nvim",
      cmd = { "FocusToggle", "FocusMaxOrEqual" },
      module = "focus",
      config = function()
        require("focus").setup { hybridnumber = true }
      end,
      disable = true,
    }
    use {
      "smjonas/live-command.nvim",
      event = { "BufReadPre" },
      config = function()
        require("live-command").setup {
          commands = {
            Norm = { cmd = "norm" },
            Reg = {
              cmd = "norm",
              args = function(opts)
                return (opts.count == -1 and "" or opts.count) .. "@" .. opts.args
              end,
              range = "",
            },
          },
        }
      end,
      disable = true,
    }
    use {
      "echasnovski/mini.nvim",
      event = { "BufReadPre" },
      config = function()
        require("config.mini").setup()
      end,
    }
    use { "MunifTanjim/nui.nvim", disable = true }
    use {
      "folke/noice.nvim",
      event = { "VimEnter" },
      config = function()
        require("config.noice").setup()
      end,
      disable = true,
    }

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

    -- Jumps
    use {
      "phaazon/hop.nvim",
      cmd = "HopWord",
      module = "hop",
      keys = { "f", "F", "t", "T" },
      config = function()
        require("config.hop").setup()
      end,
      disable = true,
    }
    use {
      "ggandor/flit.nvim",
      keys = { "f", "F", "t", "T" },
      config = function()
        require("flit").setup()
      end,
      requires = { "ggandor/leap.nvim" },
      disable = true,
    }
    use {
      "ggandor/leap.nvim",
      keys = { "s", "S" },
      config = function()
        local leap = require "leap"
        leap.add_default_mappings()
      end,
      disable = false,
    }
    use {
      "abecodes/tabout.nvim",
      after = { "nvim-cmp" },
      config = function()
        require("tabout").setup {
          completion = false,
          ignore_beginning = true,
        }
      end,
    }
    use { "AndrewRadev/splitjoin.vim", keys = { "gS", "gJ" }, disable = false }
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
      requires = { "nvim-lua/plenary.nvim", "Pocco81/TrueZen.nvim" },
      disable = true,
    }
    use {
      "phaazon/mind.nvim",
      requires = { "nvim-lua/plenary.nvim" },
      config = function()
        require("mind").setup()
      end,
      disable = true,
    }

    -- Status line
    use {
      "nvim-lualine/lualine.nvim",
      event = "BufReadPre",
      config = function()
        require("config.lualine").setup()
      end,
    }

    -- Treesitter
    use {
      "nvim-treesitter/nvim-treesitter",
      run = ":TSUpdate",
      config = function()
        require("config.treesitter").setup()
      end,
      requires = {
        { "nvim-treesitter/nvim-treesitter-textobjects", event = "BufReadPre" },
        { "windwp/nvim-ts-autotag", event = "InsertEnter" },
        { "JoosepAlviste/nvim-ts-context-commentstring", event = "BufReadPre" },
        { "p00f/nvim-ts-rainbow", event = "BufReadPre", disable = true },
        { "RRethy/nvim-treesitter-textsubjects", event = "BufReadPre" },
        { "nvim-treesitter/playground", cmd = { "TSPlaygroundToggle" } },
        -- {
        --   "lewis6991/spellsitter.nvim",
        --   config = function()
        --     require("spellsitter").setup()
        --   end,
        -- },
        { "nvim-treesitter/nvim-treesitter-context", event = "BufReadPre", disable = true },
        { "mfussenegger/nvim-treehopper", module = { "tsht" }, disable = true },
        {
          "m-demare/hlargs.nvim",
          config = function()
            require("config.hlargs").setup()
          end,
          disable = false,
        },
        {
          "AckslD/nvim-FeMaco.lua",
          config = function()
            require("femaco").setup()
          end,
          ft = { "markdown" },
          cmd = { "Femaco" },
          module = { "femaco_edit" },
          disable = true,
        },
        -- { "yioneko/nvim-yati", event = "BufReadPre" },
      },
    }

    use {
      "nvim-telescope/telescope.nvim",
      event = { "VimEnter" },
      config = function()
        require("config.telescope").setup()
      end,
      requires = {
        "nvim-lua/popup.nvim",
        "nvim-lua/plenary.nvim",
        {
          "nvim-telescope/telescope-fzf-native.nvim",
          run = "make",
        },
        { "nvim-telescope/telescope-project.nvim" },
        { "cljoly/telescope-repo.nvim" },
        { "nvim-telescope/telescope-file-browser.nvim" },
        {
          "nvim-telescope/telescope-frecency.nvim",
          requires = "tami5/sqlite.lua",
        },
        {
          "ahmedkhalf/project.nvim",
          config = function()
            require("config.project").setup()
          end,
        },
        { "nvim-telescope/telescope-dap.nvim" },
        {
          "AckslD/nvim-neoclip.lua",
          requires = {
            { "tami5/sqlite.lua", module = "sqlite" },
          },
        },
        { "nvim-telescope/telescope-smart-history.nvim" },
        {
          "alpha2phi/telescope-arecibo.nvim",
          rocks = { "openssl", "lua-http-parser" },
        },
        { "nvim-telescope/telescope-media-files.nvim" },
        { "dhruvmanila/telescope-bookmarks.nvim" },
        { "nvim-telescope/telescope-github.nvim" },
        { "jvgrootveld/telescope-zoxide" },
        { "Zane-/cder.nvim" },
        "nvim-telescope/telescope-symbols.nvim",
        -- "nvim-telescope/telescope-ui-select.nvim",
      },
    }

    -- nvim-tree
    use {
      "nvim-tree/nvim-tree.lua",
      opt = true,
      cmd = { "NvimTreeToggle", "NvimTreeClose" },
      config = function()
        require("config.nvimtree").setup()
      end,
    }
    use { "elihunter173/dirbuf.nvim", cmd = { "Dirbuf" } }

    -- Buffer line
    use {
      "akinsho/nvim-bufferline.lua",
      event = "BufReadPre",
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
    use {
      "ray-x/guihua.lua",
      run = "cd lua/fzy && make",
      disable = true,
    }
    use {
      "doums/suit.nvim",
      config = function()
        require("suit").setup {}
      end,
      disable = true,
    }

    -- Completion
    use {
      "hrsh7th/nvim-cmp",
      event = "InsertEnter",
      opt = true,
      config = function()
        require("config.cmp").setup()
      end,
      requires = {
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-nvim-lua",
        "ray-x/cmp-treesitter",
        "hrsh7th/cmp-cmdline",
        "saadparwaiz1/cmp_luasnip",
        { "hrsh7th/cmp-nvim-lsp", module = { "cmp_nvim_lsp" } },
        "hrsh7th/cmp-nvim-lsp-signature-help",
        "lukas-reineke/cmp-rg",
        "davidsierradz/cmp-conventionalcommits",
        { "onsails/lspkind-nvim", module = { "lspkind" } },
        -- "hrsh7th/cmp-calc",
        -- "f3fora/cmp-spell",
        -- "hrsh7th/cmp-emoji",
        {
          "L3MON4D3/LuaSnip",
          config = function()
            require("config.snip").setup()
          end,
          module = { "luasnip" },
        },
        "rafamadriz/friendly-snippets",
        "honza/vim-snippets",
        { "tzachar/cmp-tabnine", run = "./install.sh", disable = true },
      },
    }

    -- Auto pairs
    use {
      "windwp/nvim-autopairs",
      opt = true,
      event = "InsertEnter",
      module = { "nvim-autopairs.completion.cmp", "nvim-autopairs" },
      config = function()
        require("config.autopairs").setup()
      end,
    }

    -- Auto tag
    use {
      "windwp/nvim-ts-autotag",
      opt = true,
      event = "InsertEnter",
      config = function()
        require("nvim-ts-autotag").setup { enable = true }
      end,
    }

    -- End wise
    use {
      "RRethy/nvim-treesitter-endwise",
      opt = true,
      event = "InsertEnter",
      disable = false,
    }

    -- LSP
    use {
      "neovim/nvim-lspconfig",
      config = function()
        require("config.lsp").setup()
      end,
      requires = {
        -- { "lvimuser/lsp-inlayhints.nvim", branch = "readme" },
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        { "jayp0521/mason-null-ls.nvim" },
        "folke/neodev.nvim",
        "RRethy/vim-illuminate",
        "jose-elias-alvarez/null-ls.nvim",
        {
          "j-hui/fidget.nvim",
          config = function()
            require("fidget").setup {}
          end,
        },
        { "b0o/schemastore.nvim", module = { "schemastore" } },
        { "jose-elias-alvarez/typescript.nvim", module = { "typescript" } },
        {
          "SmiteshP/nvim-navic",
          -- "alpha2phi/nvim-navic",
          config = function()
            require("nvim-navic").setup {}
          end,
          module = { "nvim-navic" },
        },
        {
          "simrat39/inlay-hints.nvim",
          config = function()
            require("inlay-hints").setup()
          end,
        },
        {
          "zbirenbaum/neodim",
          event = "LspAttach",
          config = function()
            require("config.neodim").setup()
          end,
          disable = true,
        },
        {
          "theHamsta/nvim-semantic-tokens",
          config = function()
            require("config.semantictokens").setup()
          end,
          disable = true,
        },
        {
          "David-Kunz/markid",
          disable = true,
        },
        {
          "simrat39/symbols-outline.nvim",
          cmd = { "SymbolsOutline" },
          config = function()
            require("symbols-outline").setup()
          end,
          disable = true,
        },
        -- {
        --   "weilbith/nvim-code-action-menu",
        --   cmd = "CodeActionMenu",
        -- },
        -- {
        --   "rmagatti/goto-preview",
        --   config = function()
        --     require("goto-preview").setup {}
        --   end,
        -- },
        -- {
        --   "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
        --   config = function()
        --     require("lsp_lines").setup()
        --   end,
        -- },
      },
    }

    -- trouble.nvim
    use {
      "folke/trouble.nvim",
      cmd = { "TroubleToggle", "Trouble" },
      module = { "trouble.providers.telescope" },
      config = function()
        require("trouble").setup {
          use_diagnostic_signs = true,
        }
      end,
    }

    -- lspsaga.nvim
    use {
      "glepnir/lspsaga.nvim",
      cmd = { "Lspsaga" },
      config = function()
        require("config.lspsaga").setup()
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
    }
    use {
      "saecki/crates.nvim",
      event = { "BufRead Cargo.toml" },
      requires = { { "nvim-lua/plenary.nvim" } },
      config = function()
        require("crates").setup {
          null_ls = {
            enabled = true,
            name = "crates.nvim",
          },
        }
      end,
      disable = false,
    }

    -- Go
    use {
      "ray-x/go.nvim",
      ft = { "go" },
      config = function()
        require("go").setup()
      end,
      disable = true,
    }

    -- Java
    use { "mfussenegger/nvim-jdtls", ft = { "java" } }

    -- Flutter
    use {
      "akinsho/flutter-tools.nvim",
      requires = { "nvim-lua/plenary.nvim" },
      config = function()
        require("config.flutter").setup()
      end,
      disable = true,
    }

    -- Kotlin
    use { "udalov/kotlin-vim", ft = { "kotlin" }, disable = true }

    -- Terminal
    use {
      "akinsho/toggleterm.nvim",
      keys = { [[<C-\>]] },
      cmd = { "ToggleTerm", "TermExec" },
      module = { "toggleterm", "toggleterm.terminal" },
      config = function()
        require("config.toggleterm").setup()
      end,
    }

    -- Debugging
    use {
      "mfussenegger/nvim-dap",
      opt = true,
      module = { "dap" },
      requires = {
        { "theHamsta/nvim-dap-virtual-text", module = { "nvim-dap-virtual-text" } },
        { "rcarriga/nvim-dap-ui", module = { "dapui" } },
        { "mfussenegger/nvim-dap-python", module = { "dap-python" } },
        "nvim-telescope/telescope-dap.nvim",
        { "leoluz/nvim-dap-go", module = "dap-go" },
        { "jbyuki/one-small-step-for-vimkind", module = "osv" },
        { "mxsdev/nvim-dap-vscode-js", module = { "dap-vscode-js" } },
        {
          "microsoft/vscode-js-debug",
          opt = true,
          run = "npm install --legacy-peer-deps && npm run compile",
          disable = false,
        },
      },
      config = function()
        require("config.dap").setup()
      end,
      disable = false,
    }

    -- vimspector
    use {
      "puremourning/vimspector",
      cmd = { "VimspectorInstall", "VimspectorUpdate" },
      fn = { "vimspector#Launch()", "vimspector#ToggleBreakpoint", "vimspector#Continue" },
      config = function()
        require("config.vimspector").setup()
      end,
      disable = true,
    }

    -- Test
    use {
      "nvim-neotest/neotest",
      requires = {
        {
          "vim-test/vim-test",
          event = { "BufReadPre" },
          config = function()
            require("config.test").setup()
          end,
        },
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
        { "nvim-neotest/neotest-vim-test", module = { "neotest-vim-test" } },
        { "nvim-neotest/neotest-python", module = { "neotest-python" } },
        { "nvim-neotest/neotest-plenary", module = { "neotest-plenary" } },
        { "nvim-neotest/neotest-go", module = { "neotest-go" } },
        { "haydenmeade/neotest-jest", module = { "neotest-jest" } },
        { "rouge8/neotest-rust", module = { "neotest-rust" } },
      },
      module = { "neotest", "neotest.async" },
      config = function()
        require("config.neotest").setup()
      end,
      disable = false,
    }
    use { "diepm/vim-rest-console", ft = { "rest" }, disable = false }
    use {
      "NTBBloodbath/rest.nvim",
      config = function()
        require("rest-nvim").setup {}
        vim.keymap.set("n", "<C-j>", "<Plug>RestNvim", { noremap = true, silent = true })
      end,
      disable = true,
    }

    -- AI completion
    use { "github/copilot.vim", event = "InsertEnter", disable = true }

    -- Legendary
    use {
      "mrjones2014/legendary.nvim",
      opt = true,
      keys = { [[<C-p>]] },
      module = { "legendary" },
      cmd = { "Legendary" },
      config = function()
        require("config.legendary").setup()
      end,
    }

    -- Harpoon
    use {
      "ThePrimeagen/harpoon",
      module = {
        "harpoon",
        "harpoon.cmd-ui",
        "harpoon.mark",
        "harpoon.ui",
        "harpoon.term",
        "telescope._extensions.harpoon",
      },
      config = function()
        require("config.harpoon").setup()
      end,
    }

    -- Refactoring
    use {
      "ThePrimeagen/refactoring.nvim",
      module = { "refactoring", "telescope" },
      keys = { [[<leader>r]] },
      config = function()
        require("config.refactoring").setup()
      end,
    }
    use { "python-rope/ropevim", run = "pip install ropevim", disable = true }
    use {
      "kevinhwang91/nvim-bqf",
      ft = "qf",
      disable = false,
      config = function()
        require("bqf").setup()
      end,
    }
    use { "kevinhwang91/nvim-hlslens", event = "BufReadPre", disable = true }
    use { "nvim-pack/nvim-spectre", module = "spectre", keys = { "<leader>s" } }
    use {
      "https://gitlab.com/yorickpeterse/nvim-pqf",
      event = "BufReadPre",
      config = function()
        require("pqf").setup()
      end,
    }
    use {
      "andrewferrier/debugprint.nvim",
      module = { "debugprint" },
      keys = { "g?p", "g?P", "g?v", "g?V", "g?o", "g?O" },
      cmd = { "DeleteDebugPrints" },
      config = function()
        require("debugprint").setup()
      end,
    }

    -- Code folding
    use {
      "kevinhwang91/nvim-ufo",
      opt = true,
      keys = { "zc", "zo", "zR", "zm" },
      wants = { "promise-async" },
      requires = "kevinhwang91/promise-async",
      config = function()
        require("ufo").setup {
          provider_selector = function(_, _)
            return { "lsp", "treesitter", "indent" }
          end,
        }
        vim.keymap.set("n", "zR", require("ufo").openAllFolds)
        vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
      end,
      disable = true,
    }

    -- Performance
    use { "dstein64/vim-startuptime", cmd = "StartupTime" }
    use {
      "nathom/filetype.nvim",
      cond = function()
        return vim.fn.has "nvim-0.8.0" == 0
      end,
    }

    -- Web
    use {
      "vuki656/package-info.nvim",
      opt = true,
      requires = {
        "MunifTanjim/nui.nvim",
      },
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
      config = function()
        require("auto-session").setup()
      end,
      disable = true,
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
      disable = true,
    }
    use {
      "sidebar-nvim/sidebar.nvim",
      cmd = { "SidebarNvimToggle" },
      config = function()
        require("sidebar-nvim").setup { open = false }
      end,
    }
    use {
      "stevearc/aerial.nvim",
      config = function()
        require("aerial").setup {
          backends = { "treesitter", "lsp" },
          on_attach = function(bufnr)
            vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
            vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
          end,
        }
      end,
      module = { "aerial", "telescope._extensions.aerial" },
      cmd = { "AerialToggle" },
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
    use {
      "potamides/pantran.nvim",
      cmd = "Pantran",
    }

    -- REPL
    use {
      "hkupty/iron.nvim",
      config = function()
        require("config.iron").setup()
      end,
      disable = true,
    }

    -- Task runner
    use {
      "stevearc/overseer.nvim",
      opt = true,
      module = { "neotest.consumers.overseer" },
      cmd = {
        "OverseerToggle",
        "OverseerOpen",
        "OverseerRun",
        "OverseerBuild",
        "OverseerClose",
        "OverseerLoadBundle",
        "OverseerSaveBundle",
        "OverseerDeleteBundle",
        "OverseerRunCmd",
        "OverseerQuickAction",
        "OverseerTaskAction",
      },
      config = function()
        require("overseer").setup()
      end,
    }
    use {
      "michaelb/sniprun",
      run = "bash ./install.sh",
      cmd = { "SnipRun", "SnipInfo", "SnipReset", "SnipReplMemoryClean", "SnipClose", "SnipLive" },
      module = { "sniprun", "sniprun.api" },
    }

    -- Database
    use {
      "tpope/vim-dadbod",
      opt = true,
      requires = {
        "kristijanhusak/vim-dadbod-ui",
        "kristijanhusak/vim-dadbod-completion",
        --[[ "abenz1267/nvim-databasehelper", ]]
      },
      config = function()
        require("config.dadbod").setup()
      end,
      cmd = { "DBUIToggle", "DBUI", "DBUIAddConnection", "DBUIFindBuffer", "DBUIRenameBuffer", "DBUILastQueryInfo" },
    }
    use {
      "nanotee/sqls.nvim",
      module = { "sqls" },
      cmd = {
        "SqlsExecuteQuery",
        "SqlsExecuteQueryVertical",
        "SqlsShowDatabases",
        "SqlsShowSchemas",
        "SqlsShowConnections",
        "SqlsSwitchDatabase",
        "SqlsSwitchConnection",
      },
    }
    use {
      "dinhhuy258/vim-database",
      run = ":UpdateRemotePlugins",
      cmd = { "VDToggleDatabase", "VDToggleQuery", "VimDatabaseListTablesFzf" },
    }

    -- Testing
    use {
      "linty-org/readline.nvim",
      event = { "BufReadPre" },
      config = function()
        require("config.readline").setup()
      end,
    }
    use {
      "protex/better-digraphs.nvim",
      config = function()
        require("config.digraph").setup()
      end,
      keys = { "r<C-k><C-k>" },
      disable = true,
    }
    use {
      "ziontee113/icon-picker.nvim",
      config = function()
        require("icon-picker").setup {
          disable_legacy_commands = true,
        }
      end,
      cmd = { "IconPickerNormal", "IconPickerYank", "IconPickerInsert" },
      disable = false,
    }

    -- use {
    --   "dgrbrady/nvim-docker",
    --   requires = { "nvim-lua/plenary.nvim", "MunifTanjim/nui.nvim" },
    --   rocks = "4O4/reactivex",
    --   module = { "nvim-docker" },
    --   disable = true,
    -- }

    use {
      "m-demare/attempt.nvim",
      opt = true,
      requires = "nvim-lua/plenary.nvim",
      module = { "attempt" },
      config = function()
        require("config.attempt").setup()
      end,
      disable = false,
    }
    use {
      "gbprod/substitute.nvim",
      event = "BufReadPre",
      config = function()
        require("config.substitute").setup()
      end,
      disable = true,
    }
    use {
      "AckslD/nvim-trevJ.lua",
      config = function()
        require("trevj").setup()
      end,
      module = "trevj",
      setup = function()
        vim.keymap.set("n", ",j", function()
          require("trevj").format_at_cursor()
        end)
      end,
      disable = true,
    }
    use {
      "narutoxy/dim.lua",
      requires = { "nvim-treesitter/nvim-treesitter", "neovim/nvim-lspconfig" },
      config = function()
        require("dim").setup {
          disable_lsp_decorations = true,
        }
      end,
      disable = true,
    }
    use {
      "linty-org/key-menu.nvim",
      config = function()
        require("config.keymenu").setup()
      end,
      event = "VimEnter",
      disable = true,
    }
    use { "mg979/vim-visual-multi", event = "BufReadPre", disable = false }
    use {
      "anuvyklack/hydra.nvim",
      config = function()
        require("config.hydra").setup()
      end,
      requires = "anuvyklack/keymap-layer.nvim",
      module = { "hydra" },
      event = { "BufReadPre" },
      disable = true,
    }
    use {
      "Olical/conjure",
      cmd = { "ConjureSchool" },
      config = function()
        vim.g["conjure#extract#tree_sitter#enabled"] = true
      end,
      disable = true,
    }

    -- Disabled
    use {
      "ziontee113/syntax-tree-surfer",
      opt = true,
      event = "BufReadPre",
      module = { "syntax-tree-surfer" },
      config = function()
        require("config.syntaxtreesurfer").setup()
      end,
      disable = true,
    }
    use {
      "ghillb/cybu.nvim",
      event = "BufReadPre",
      config = function()
        require("config.cybu").setup()
      end,
      disable = true,
    }
    use { "tversteeg/registers.nvim", disable = true }
    use {
      "TaDaa/vimade",
      cmd = { "VimadeToggle", "VimadeEnable", "VimadeDisable" },
      disable = true,
      config = function()
        vim.g.vimade.fadelevel = 0.7
        vim.g.vimade.enablesigns = 1
      end,
    }
    use {
      "AckslD/nvim-gfold.lua",
      config = function()
        require("gfold").setup()
      end,
      disable = true,
    }
    use {
      "epwalsh/obsidian.nvim",
      disable = true,
      config = function()
        require("obsidian").setup {
          dir = "~/my-notes",
          completion = {
            nvim_cmp = true, -- if using nvim-cmp, otherwise set to false
          },
        }
      end,
    }

    -- https://github.com/WhoIsSethDaniel/toggle-lsp-diagnostics.nvim
    -- https://github.com/rbong/vim-buffest
    -- https://github.com/jamestthompson3/nvim-remote-containers
    -- https://github.com/esensar/nvim-dev-container
    -- https://github.com/mrjones2014/smart-splits.nvim
    -- https://github.com/ziontee113/icon-picker.nvim
    -- https://github.com/rktjmp/lush.nvim
    -- https://github.com/charludo/projectmgr.nvim
    -- https://github.com/katawful/kreative
    -- https://github.com/kevinhwang91/nvim-ufo

    -- Bootstrap Neovim
    if is_boostrap then
      print "Neovim restart is required after installation!"
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
