return {
  -- tools
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "stylua",
        "selene",
        "luacheck",
        "shellcheck",
        "shfmt",
        "tailwindcss-language-server",
        "typescript-language-server",
        "css-lsp",
      })
    end,
  },

  -- lsp servers
  {
    "neovim/nvim-lspconfig",
    init = function()
      local lsp_keys = require("lazyvim.plugins.lsp.keymaps")
      local keys = lsp_keys.get()
      keys[#keys + 1] = { "K", false }
      keys[#keys + 1] = { "<leader>h", "<cmd>lua vim.lsp.buf.hover()<cr>" }
      keys[#keys + 1] = { "C-k", false }
    end,
    opts = {
      ---@type lspconfig.options
      servers = {
        eslint = {
          settings = {
            -- helps eslint find the eslintrc when it's placed in a subfolder instead of the cwd root
            workingDirectories = { mode = "auto" },
          },
        },
        tailwindcss = {
          root_dir = function(...)
            return require("lspconfig.util").root_pattern(".git")(...)
          end,
        },
      },
      setup = {
        eslint = function()
          local function get_client(buf)
            return require("lazyvim.util").lsp.get_clients({ name = "eslint", bufnr = buf })[1]
          end

          local formatter = require("lazyvim.util").lsp.formatter({
            name = "eslint: lsp",
            primary = false,
            priority = 200,
            filter = "eslint",
          })

          -- Use EslintFixAll on Neovim < 0.10.0
          if not pcall(require, "vim.lsp._dynamic") then
            formatter.name = "eslint: EslintFixAll"
            formatter.sources = function(buf)
              local client = get_client(buf)
              return client and { "eslint" } or {}
            end
            formatter.format = function(buf)
              local client = get_client(buf)
              if client then
                local diag = vim.diagnostic.get(buf, { namespace = vim.lsp.diagnostic.get_namespace(client.id) })
                if #diag > 0 then
                  vim.cmd("EslintFixAll")
                end
              end
            end
          end

          -- register the formatter with LazyVim
          require("lazyvim.util").format.register(formatter)
        end,
      },
      tsserver = {
        root_dir = function(...)
          return require("lspconfig.util").root_pattern(".git")(...)
        end,
      },
    },
    -- opts = {
    --   inlay_hints = { enabled = false },
    --   ---@type lspconfig.options
    --   servers = {
    --     cssls = {},
    --     tailwindcss = {
    --       root_dir = function(...)
    --         return require("lspconfig.util").root_pattern(".git")(...)
    --       end,
    --     },
    --     tsserver = {
    --       root_dir = function(...)
    --         return require("lspconfig.util").root_pattern(".git")(...)
    --       end,
    --       single_file_support = false,
    --       settings = {
    --         typescript = {
    --           inlayHints = {
    --             includeInlayParameterNameHints = "literal",
    --             includeInlayParameterNameHintsWhenArgumentMatchesName = false,
    --             includeInlayFunctionParameterTypeHints = true,
    --             includeInlayVariableTypeHints = false,
    --             includeInlayPropertyDeclarationTypeHints = true,
    --             includeInlayFunctionLikeReturnTypeHints = true,
    --             includeInlayEnumMemberValueHints = true,
    --           },
    --         },
    --         javascript = {
    --           inlayHints = {
    --             includeInlayParameterNameHints = "all",
    --             includeInlayParameterNameHintsWhenArgumentMatchesName = false,
    --             includeInlayFunctionParameterTypeHints = true,
    --             includeInlayVariableTypeHints = true,
    --             includeInlayPropertyDeclarationTypeHints = true,
    --             includeInlayFunctionLikeReturnTypeHints = true,
    --             includeInlayEnumMemberValueHints = true,
    --           },
    --         },
    --       },
    --     },
    --     html = {},
    --     yamlls = {
    --       settings = {
    --         yaml = {
    --           keyOrdering = false,
    --         },
    --       },
    --     },
    --     lua_ls = {
    --       -- enabled = false,
    --       single_file_support = true,
    --       settings = {
    --         Lua = {
    --           workspace = {
    --             checkThirdParty = false,
    --           },
    --           completion = {
    --             workspaceWord = true,
    --             callSnippet = "Both",
    --           },
    --           misc = {
    --             parameters = {
    --               -- "--log-level=trace",
    --             },
    --           },
    --           hint = {
    --             enable = true,
    --             setType = false,
    --             paramType = true,
    --             paramName = "Disable",
    --             semicolon = "Disable",
    --             arrayIndex = "Disable",
    --           },
    --           doc = {
    --             privateName = { "^_" },
    --           },
    --           type = {
    --             castNumberToInteger = true,
    --           },
    --           diagnostics = {
    --             disable = { "incomplete-signature-doc", "trailing-space" },
    --             -- enable = false,
    --             groupSeverity = {
    --               strong = "Warning",
    --               strict = "Warning",
    --             },
    --             groupFileStatus = {
    --               ["ambiguity"] = "Opened",
    --               ["await"] = "Opened",
    --               ["codestyle"] = "None",
    --               ["duplicate"] = "Opened",
    --               ["global"] = "Opened",
    --               ["luadoc"] = "Opened",
    --               ["redefined"] = "Opened",
    --               ["strict"] = "Opened",
    --               ["strong"] = "Opened",
    --               ["type-check"] = "Opened",
    --               ["unbalanced"] = "Opened",
    --               ["unused"] = "Opened",
    --             },
    --             unusedLocalExclude = { "_*" },
    --           },
    --           format = {
    --             enable = false,
    --             defaultConfig = {
    --               indent_style = "space",
    --               indent_size = "2",
    --               continuation_indent_size = "2",
    --             },
    --           },
    --         },
    --       },
    --     },
    --   },
    --   setup = {},
    -- },
  },
}
