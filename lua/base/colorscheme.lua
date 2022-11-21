-- local colorscheme = "tokyonight-night"
-- local colorscheme = "dracula"
-- local colorscheme = "gruvbox"
-- local colorscheme = "onedarkpro"
-- local colorscheme = "gruvbox"
-- local colorscheme = "monokai"

-- require('base.colors.dracula-nvim')
-- require("base.colors.gruvbox")
-- require("base.colors.kanagawa")
-- require("base.colors.material")
-- require("base.colors.catppuccin")
require("base.colors.zephyr")

-- vim.cmd("colorscheme dracula")
-- vim.cmd("colorscheme zephyr")

-- hi Normal guibg=None
vim.cmd([[
  hi SignColumn guibg=None 
 
  hi NvimTreeNormal guibg=None
  hi NvimTreeCursorLine guibg=#483D8B
  hi Pmenu guibg=None
  hi PmenuSel guibg=#483D8B
  hi PmenuThumb guibg=#483D8B

  hi TelescopePreviewNormal guibg=None 
  hi TelescopePromptCounter guifg=#483D8B
  hi TelescopeNormal guifg=#483d8b
  hi TelescopeResultsNormal guifg=#944dff

  hi NoicePopup guifg=#afafaf guibg=None
  hi NoicePopupBorder guifg=#875fff

 hi rainbowcol1 guifg=#ff79c6

]])
