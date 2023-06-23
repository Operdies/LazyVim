return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      -- Disable snippets in completion
      { "hrsh7th/cmp-nvim-lsp-signature-help" },
    },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local cmp = require("cmp")

      -- Disable auto selection of first item in completion (1)
      opts.completion = {
        completeopt = "menu,menuone,noinsert,noselect",
      }

      opts.mapping = vim.tbl_extend("force", opts.mapping, {
        ["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
        ["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
        ["<CR>"] = cmp.mapping.confirm({ select = false }),
      })

      -- Disable auto selection of first item in completion (2)
      opts.preselect = require("cmp").PreselectMode.None

      opts.sources = cmp.config.sources(vim.list_extend(opts.sources, {
        { name = "copilot" },
        { name = "nvim_lsp_signature_help" },
      }))

      -- callback for whenever cmp is triggered
      cmp.event:on("menu_opened", function()
        -- autocmd callback for before a char is inserted
        vim.api.nvim_create_autocmd("InsertCharPre", {
          callback = function(_)
            -- if no entry is selected do nothing
            if (cmp.get_selected_entry()) ~= nil then
              -- store the to-be-inserted char
              local c = vim.v.char
              -- clear the to-be-inserted char
              vim.v.char = ""
              -- vim schedule to circumvent `textlock`
              vim.schedule(function()
                -- confirm cmp selection - i. e. insert selected text
                cmp.confirm({ select = false })
                -- insert the stored char
                vim.api.nvim_feedkeys(c, "n", false)
              end)
            end
          end,
          once = true,
        })
      end)
    end,
  },
}
