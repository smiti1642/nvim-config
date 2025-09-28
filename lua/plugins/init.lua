return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "github/copilot.vim",
    lazy = false,
    config = function() -- Mapping tab is already used in NvChad
      vim.g.copilot_no_tab_map = true; -- Disable tab mapping
      vim.g.copilot_assume_mapped = true; -- Assume that the mapping is already done
    end
  },

  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "github/copilot.vim" }, -- or zbirenbaum/copilot.lua
      { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
    },
    -- build = "make tiktoken", -- Only on MacOS or Linux
    lazy = false,

    config = function()
      local function slurp(path)
        local file = io.open(path, "r")
        if not file then
          return ""
        end
        local content = file:read "*all"
        file:close()
        return content
      end

      local prompt_path = vim.fn.getcwd() .. "/.github/prompt.md"
      local custom_prompt = slurp(prompt_path)
      if custom_prompt then
        require("CopilotChat").setup {
          system_prompt = custom_prompt,
        }
        print "[CopilotChat] Loaded project custom prompt"
      else
        print "[CopilotChat] No custom prompt found for this project, using default Copilot behavior"
      end
    end,
    -- See Commands section for default commands if you want to lazy load on them
  },

   -- test new blink
  { import = "nvchad.blink.lazyspec" },

  -- For CopilotChat, and need to install fzf in terminal
  {
    "ibhagwan/fzf-lua",
    config = function()
      require("fzf-lua").register_ui_select()
    end,
    lazy = false, -- Load fzf-lua on startup
  },

  -- {
  -- 	"nvim-treesitter/nvim-treesitter",
  -- 	opts = {
  -- 		ensure_installed = {
  -- 			"vim", "lua", "vimdoc",
  --      "html", "css"
  -- 		},
  -- 	},
  -- },
}
