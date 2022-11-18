local ok, dap = pcall(require, "dap")
if not ok then return end

require("dapui").setup({
    icons = { expanded = "▾", collapsed = "▸", current_frame = "->" },
})

require("nvim-dap-virtual-text").setup()

local dap, dapui = require("dap"), require("dapui")
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

require('dap-python').test_runner = 'pytest'
require('dap-python').setup()
-- require('dap-python').setup('~/.virtualenvs/debugpy/bin/python')

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
    require('dap-python').test_method()
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


-- nnoremap <silent> <leader>dn :lua require('dap-python').test_method()<CR>
-- nnoremap <silent> <leader>df :lua require('dap-python').test_class()<CR>
-- vnoremap <silent> <leader>ds <ESC>:lua require('dap-python').debug_selection()<CR>
