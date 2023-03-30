-- ################################################## 按键映射 ##################################################
local keymaps = require('custom.keymaps')
local map = keymaps.map

-- -------------------------------------------------- 基础按键 --------------------------------------------------
-- F4 (新增/移除)断点
map('n', '<F4>', '<cmd> lua require("dap").toggle_breakpoint() <CR>')
-- F7 跳出当前函数
map('n', '<F7>', '<cmd> lua require("dap").step_out() <CR>')
-- F8 进入当前函数
map('n', '<F8>', '<cmd> lua require("dap").step_into() <CR>')
-- F9 执行下一步
map('n', '<F9>', '<cmd> lua require("dap").step_over() <CR>')
-- F10 停止调试
map('n', '<F10>', '<cmd> lua require("dap").close() <CR>')
-- F11 (启动/继续)调试
map('n', '<F11>', '<cmd> lua require("dap").continue() <CR>')
-- F12 运行到最后一步
map('n', '<F12>', '<cmd> lua require("dap").run_last() <CR>')
