local md_highlight = "#14161a"
return {
  {
    "olimorris/onedarkpro.nvim",
    priority = 1000, -- Ensure it loads first
    opts = {
      styles = { -- For example, to apply bold and italic, use "bold,italic"
        comments = "italic", -- Style that is applied to comments
        virtual_text = "bold", -- Style that is applied to virtual text
      },
      options = {
        cursorline = false, -- use cursorline highlighting?
        transparency = true, -- use a transparent background?
        lualine_transparency = true,
        terminal_colors = true, -- use the theme's colors for neovim's :terminal?
        highlight_inactive_windows = false, -- when the window is out of focus, change the normal background?
        bold = false,
        italic = true,
        underline = true,
        undercurl = true,
        highlights = {},
        ["@text.emphasis"] = { italic = true },
        ["@tag.html"] = { fg = "#89ca78" },
        ["@text.todo.unchecked"] = { bg = md_highlight },
        Headline = { bg = md_highlight },
        CodeBlock = { bg = md_highlight },
        WhichKeyFloat = { bg = nil }, -- transparent whichkey
        TabLineSel = { bg = "#22272f", bold = true },
        MiniStatuslineModeNormal = { bg = "#22272f" },
        LazyButton = { bg = "#22272f" },
        TreeSitterContext = { bg = "#22272f" },
        Visual = { bg = "#54565D", fg = "#000000" },
        -- Comment = { fg = "#000000" },
      },
    },
    config = function(_, opts)
      require("onedarkpro").setup(opts)
      vim.cmd([[colorscheme onedark]])
    end,
  },
}
