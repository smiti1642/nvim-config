require "nvchad.options"

-- add yours here!

-- o.cursorlineopt ='both' -- to enable cursorline!
local o = vim.o
o.rnu = true
o.number = true
o.tabstop = 4
o.shiftwidth = 4
o.expandtab = true
o.softtabstop = 4

-- folding
-- 程式碼折疊
local opt = vim.opt
opt.foldmethod = "expr"
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
opt.foldenable = true      -- 預設啟用折疊
opt.foldlevel = 99         -- 預設展開全部
opt.foldlevelstart = 99    -- 開啟檔案時的預設展開層級
