return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "Hoffs/omnisharp-extended-lsp.nvim",
    },
    opts = {
      autoformat = false,
      ---@type lspconfig.options
      servers = {
        helm_ls = {
          cmd = { "helm_ls", "serve" },
          filetypes = { "helm" },
          mason = false,
        },
        rust_analyzer = {
          settings = {
            ["rust-analyzer"] = {
              ---@diagnostic disable-next-line: assign-type-mismatch
              checkOnSave = {
                command = "clippy",
              },
              diagnostics = {
                enable = true,
                -- There is a bug in rust-analyzer causing this to trigger constantly.
                -- TODO: Check if this is fixed at some point
                disabled = { "unresolved-proc-macro" },
                enableExperimental = true,
              },
            },
          },
        },
        omnisharp = {
          filetypes = { "cs", "csx" },
          root_dir = function(fname)
            if fname:sub(-#".csx") == ".csx" then
              return require("lspconfig").util.path.dirname(fname)
            end
            return vim.fn.getcwd()
          end,
        },
      },
      setup = {
        clangd = function(_, opts)
          opts.capabilities.offsetEncoding = { "utf-16" }
        end,
        helm_ls = function(_, _)
          local configs = require("lspconfig.configs")
          if not configs.helm_ls then
            configs.helm_ls = {
              default_config = {
                cmd = { "helm_ls", "serve" },
                filetypes = { "helm" },
                root_dir = function(fname)
                  local util = require("lspconfig.util")
                  return util.root_pattern("Chart.yaml")(fname)
                end,
              },
            }
          end
          return false
        end,
        tailwindcss = function()
          require("lazyvim.util").on_attach(function(client, _)
            if client.name == "tailwindcss" then
              client.server_capabilities.documentFormattingProvider = true
            end
          end)
        end,
        eslint = function()
          require("lazyvim.util").on_attach(function(client, _)
            if client.name == "eslint" then
              client.server_capabilities.documentFormattingProvider = true
            end
          end)
        end,
        omnisharp = function(_, opts)
          opts.handlers = {
            ["textDocument/definition"] = require("omnisharp_extended").handler,
          }
          require("lazyvim.util").on_attach(function(client, _)
            -- INFO https://github.com/OmniSharp/omnisharp-roslyn/issues/2483
            if client.name == "omnisharp" then
              client.server_capabilities.semanticTokensProvider.legend = {
                tokenModifiers = { "static" },
                tokenTypes = {
                  "comment",
                  "excluded",
                  "identifier",
                  "keyword",
                  "keyword",
                  "number",
                  "operator",
                  "operator",
                  "preprocessor",
                  "string",
                  "whitespace",
                  "text",
                  "static",
                  "preprocessor",
                  "punctuation",
                  "string",
                  "string",
                  "class",
                  "delegate",
                  "enum",
                  "interface",
                  "module",
                  "struct",
                  "typeParameter",
                  "field",
                  "enumMember",
                  "constant",
                  "local",
                  "parameter",
                  "method",
                  "method",
                  "property",
                  "event",
                  "namespace",
                  "label",
                  "xml",
                  "regexp",
                },
              }
            end
          end)
          return false
        end,
      },
    },
  },
}
