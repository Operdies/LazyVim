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
        colors.comment = "#868fa9"
      end,
    },
  },
}
