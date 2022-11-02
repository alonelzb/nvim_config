-- local colorscheme = "tokyonight-night"
-- local colorscheme = "dracula"
-- local colorscheme = "gruvbox"
-- local colorscheme = "onedarkpro"
-- local colorscheme = "gruvbox"
-- local colorscheme = "monokai"

-- require('base.colors.dracula-nvim')
-- require("base.colors.gruvbox")
-- require("base.colors.kanagawa")
require("base.colors.material")
-- require("base.colors.catppuccin")
-- vim.cmd("colorscheme dracula")

-- hi Normal guibg=None
vim.cmd([[
  hi NvimTreeNormal guibg=None
  hi NvimTreeCursorLine guibg=#483D8B
  hi Pmenu guibg=None
  hi PmenuSel guibg=#483D8B
  hi PmenuThumb guibg=#483D8B

  hi TelescopePreviewNormal guibg=None 
  hi TelescopePromptCounter guifg=#483D8B
  hi TelescopeNormal guifg=#483d8b
  hi TelescopeResultsNormal guifg=#944dff

 hi rainbowcol1 guifg=#ff79c6

]])
