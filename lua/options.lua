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

-- 設定 Git Bash 為 Windows 的預設 shell
local function find_git_bash()
  if not vim.loop.os_uname().version:match("Windows") then
    return nil
  end

  -- 1. 用 where git 找 git.exe
  local git_paths = vim.fn.systemlist("where git")
  if git_paths and #git_paths > 0 then
    for _, gpath in ipairs(git_paths) do
      if gpath:match("Git") then
        local root = gpath:gsub("[/\\]cmd[/\\]git.exe", "")
        local bash1 = root .. "\\bin\\bash.exe"
        local bash2 = root .. "\\usr\\bin\\bash.exe"

        if vim.loop.fs_stat(bash1) then return bash1 end
        if vim.loop.fs_stat(bash2) then return bash2 end
      end
    end
  end

  -- 2. 最後掃描常見路徑
  local fallback_paths = {
    "C:/Program Files/Git/bin/bash.exe",
    "C:/Program Files (x86)/Git/bin/bash.exe",
    os.getenv("USERPROFILE") .. "/AppData/Local/Programs/Git/bin/bash.exe",
    os.getenv("USERPROFILE") .. "/scoop/apps/git/current/bin/bash.exe",
  }

  for _, p in ipairs(fallback_paths) do
    if vim.loop.fs_stat(p) then
      return p
    end
  end

  return nil
end

local bash = find_git_bash()
if bash then
  opt.shell = bash
  opt.shellcmdflag = "-c"
  opt.shellquote = ""
  opt.shellxquote = ""
  print("[NvChad] Git Bash detected: " .. bash)
end
