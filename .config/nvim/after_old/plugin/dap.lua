local ok, dap = pcall(require, "dap")
if not ok then return end

-- local M = {}
--
-- function M.start_devenv_debug_session()
--   local service_name = vim.fn.input("\nDebugee Service: ")
--   local port = M.get_debugging_port(service_name) or vim.fn.input("\nDebuggee Port: ")
--   -- Start the debugger in the devenv service.
--   vim.fn.system({ ensure_script, service_name })
--   io.write(string.format("Debug session for %s with port %d", service_name, port))
--   return service_name, port
-- end
--
-- function M.get_devenv_host()
--   local remoteness = vim.fn.input("\nRemote or Local Devenv: ")
--   local host
--   if remoteness == "remote" then
--     host = "10.132.2.22"
--   elseif remoteness == "local" then
--     host = "127.0.0.1"
--   else
--     io.write(string.format("Unusable remoteness value: %s", remoteness))
--   end
--   return host
-- end
--
--
-- -- =============================
-- --            ADAPTERS
-- -- =============================
-- M.adapters = {}
--
-- M.adapters.python = {
--   type = "executable",
--   -- command = os.getenv("HOME") .. "/.pyenv/versions/neovim3/bin/python",
--   command = "python",
--   args = { "-m", "debugpy.adapter" },
-- }
--
-- M.adapters.devenv_python = function(cb, config)
--   local _, port = M.start_devenv_debug_session()
--   local host = M.get_devenv_host()
--   cb({
--     type = "server",
--     host = host,
--     port = port,
--     enrich_config = function(config, on_config)
--       local f_config = vim.deepcopy(config)
--       if f_config.connect ~= nil then
--         f_config.connect.port = port
--         f_config.connect.host = host
--       end
--       on_config(f_config)
--     end,
--   })
-- end

-- =============================
--        CONFIGURATIONS
-- =============================

-- M.configurations = {
--   {
--     type = "devenv-python",
--     request = "attach",
--     mode = "remote",
--     connect = {},
--     name = "Devenv Debugger",
--     cwd = vim.fn.getcwd(),
--     pathMappings = {
--       {
--         localRoot = vim.fn.getcwd(),
--         remoteRoot = "/app",
--       },
--     },
--   },
-- }


require("nvim-dap-virtual-text").setup()

local dap, dapui = require("dap"), require("dapui")

dapui.setup({ expanded = "▾", collapsed = "▸", current_frame = "->" })

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

local dap_python = require("dap-python")
dap_python.setup()
dap_python.test_runner = 'pytest'

-- require('dap-python').setup('~/.virtualenvs/debugpy/bin/python')


-- dap.adapters.python = M.adapters.python


local map = function(lhs, rhs, desc)
  if desc then
    desc = "[DAP] " .. desc
  end

  vim.keymap.set("n", lhs, rhs, {})
end

map("<leader>db", require("dap").toggle_breakpoint)
map("<leader>dB", function()
  dap.set_breakpoint(vim.fn.input "[DAP] Condition > ")
end)

map("<leader>ds", function()
  dap_python.test_method()
end)

map("<leader><leader>", function()
  dap.close()
  dapui.close()
end)

map("<Up>", function()
  dap.continue()
end)
map("<Down>", function()
  dap.step_over()
end)
map("<Right>", function()
  dap.step_into()
end)
map("<Left>", function()
  dap.step_out()
end)

-- local dap_python = require("dap-python")
-- dap_python.setup("~/.pyenv/versions/neovim3/bin/python")
-- dap_python.test_runner = "pytest"


-- local M = {}
-- M.attach_python_debugger = function(args)
--     local dap = require "dap"
--     local host = args[1] -- This should be configured for remote debugging if your SSH tunnel is setup.
--     -- You can even make nvim responsible for starting the debugpy server/adapter:
--     --  vim.fn.system({"${some_script_that_starts_debugpy_in_your_container}", ${script_args}})
--     pythonAttachAdapter = {
--         type = "server";
--         host = host;
--         port = tonumber(9000);
--     }
--     pythonAttachConfig = {
--         type = "python";
--         request = "attach";
--         connect = {
--             port = tonumber(9000);
--             host = host;
--         };
--         mode = "remote";
--         name = "Remote Attached Debugger";
--         cwd = vim.fn.getcwd();
--         pathMappings = {
--             {
--                 localRoot = vim.fn.getcwd(); -- Wherever your Python code lives locally.
--                 remoteRoot = "/app"; -- Wherever your Python code lives in the container.
--             };
--         };
--     }
--     local session = dap.attach(host, tonumber(9000), pythonAttachConfig)
--     if session == nil then
--         io.write("Error launching adapter");
--     end
--     dap.repl.open()
-- end

-- nnoremap <silent> <leader>dn :lua require('dap-python').test_method()<CR>
-- nnoremap <silent> <leader>df :lua require('dap-python').test_class()<CR>
-- vnoremap <silent> <leader>ds <ESC>:lua require('dap-python').debug_selection()<CR>
-- 
require('telescope').load_extension('dap')
