local dap = require("dap")
local dapui = require("dapui")

require("mason-nvim-dap").setup {
  ensure_installed = { "codelldb", "debugpy" },
}

local function codelldb_paths()
  local base = vim.fs.joinpath(vim.fn.stdpath("data"), "mason", "packages", "codelldb", "extension")
  local sysname = vim.loop.os_uname().sysname
  local is_windows = sysname:match("Windows") ~= nil

  local adapter = vim.fs.joinpath(base, "adapter", is_windows and "codelldb.exe" or "codelldb")

  local lib_dir
  local lib_name
  if sysname == "Darwin" then
    lib_dir = "lib"
    lib_name = "liblldb.dylib"
  elseif is_windows then
    lib_dir = "bin"
    lib_name = "liblldb.dll"
  else
    lib_dir = "lib"
    lib_name = "liblldb.so"
  end
  local liblldb = vim.fs.joinpath(base, "lldb", lib_dir, lib_name)

  return adapter, liblldb, is_windows
end

local function configure_codelldb()
  local adapter, liblldb, is_windows = codelldb_paths()
  if not vim.loop.fs_stat(adapter) then
    vim.notify(
      string.format("[dap] 找不到 codelldb adapter：%s\n請先用 :Mason 安裝 codelldb。", adapter),
      vim.log.levels.ERROR
    )
    return
  end

  dap.adapters.codelldb = {
    type = "server",
    host = "127.0.0.1",
    port = "${port}",
    executable = {
      command = adapter,
      args = { "--liblldb", liblldb, "--port", "${port}" },
      detached = is_windows,
    },
  }

  local function pick_program()
    return vim.fn.input("可執行檔路徑: ", vim.fn.getcwd() .. "/", "file")
  end

  local function pick_args()
    local input = vim.fn.input("程式參數: ")
    if input == "" then
      return {}
    end
    local args = {}
    for arg in input:gmatch("%S+") do
      table.insert(args, arg)
    end
    return args
  end

  local shared = {
    {
      name = "Launch",
      type = "codelldb",
      request = "launch",
      program = pick_program,
      cwd = "${workspaceFolder}",
      stopOnEntry = false,
      args = pick_args,
      runInTerminal = false,
    },
    {
      name = "Attach",
      type = "codelldb",
      request = "attach",
      pid = require("dap.utils").pick_process,
      cwd = "${workspaceFolder}",
    },
  }

  dap.configurations.cpp = vim.deepcopy(shared)
  dap.configurations.c = vim.deepcopy(shared)
  dap.configurations.rust = vim.deepcopy(shared)
end

configure_codelldb()

-- VS-style breakpoint/stopped icons with color highlights
local sign = vim.fn.sign_define
local hl = vim.api.nvim_set_hl

hl(0, "DapBreakpoint", { fg = "#ff5555" })
hl(0, "DapStopped", { fg = "#00ff88" })
hl(0, "DapBreakpointCondition", { fg = "#f6c177" })
hl(0, "DapLogPoint", { fg = "#61afef" })

sign("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = "" })
sign("DapBreakpointCondition", { text = "●", texthl = "DapBreakpointCondition", linehl = "", numhl = "" })
sign("DapBreakpointRejected", { text = "", texthl = "DiagnosticError", linehl = "", numhl = "" })
sign("DapLogPoint", { text = "◆", texthl = "DapLogPoint", linehl = "", numhl = "" })
sign("DapStopped", { text = "", texthl = "DapStopped", linehl = "CursorLine", numhl = "" })

dapui.setup()

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end
