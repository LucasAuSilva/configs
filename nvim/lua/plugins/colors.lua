
return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  opts = {
    integrations = {
      semantic_tokens = true,
    },
    custom_highlights = function(_colors)
      return {
        LineNr = { fg = "#8087A2" },
        CursorLineNr = { fg = "#F5BDE6", style = { "bold" } },
      }
    end,
  },

  config = function(_, opts)
    require("catppuccin").setup(opts)
    vim.cmd.colorscheme("catppuccin-nvim")

    -- Keep the background transparent
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
  end,
}
