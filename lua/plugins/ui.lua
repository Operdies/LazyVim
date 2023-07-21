return {
  {
    "folke/tokyonight.nvim",
    opts = {
      style = "night",
      dim_inactive = true,
      on_colors = function(colors)
        colors.bg = "#0D1117"
        colors.border = "#343434"
        colors.bg_dark = "#000000"
      end,
    },
  },
  {
    enabled = false,
    "shaunsingh/solarized.nvim",
    config = function(_, opts)
      require("solarized").set()
      vim.o.background = "light"
      vim.g.solarized_italic_comments = true
      vim.g.solarized_italic_keywords = true
      vim.g.solarized_italic_functions = true
      vim.g.solarized_italic_variables = false
      vim.g.solarized_contrast = true
      vim.g.solarized_borders = false
      vim.g.solarized_disable_background = false
    end,
  },
  {
    enabled = false,
    "ellisonleao/gruvbox.nvim",
    config = function(_, opts)
      require("gruvbox").setup(opts)
      vim.o.background = "dark"
    end,
    opts = {
      bold = false,
      -- italic = false,
      contrast = "hard",
      invert_tabline = true,
    },
  },
  {
    "tiagovla/scope.nvim",
    config = function()
      require("scope").setup()
    end,
    event = "VeryLazy",
  },
  { "folke/noice.nvim", opts = { messages = { enabled = false } } },
}
