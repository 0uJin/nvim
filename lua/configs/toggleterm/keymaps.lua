-- ################################################## 按键映射 ##################################################
local keymaps = require('custom.keymaps')
local noremap = keymaps.noremap

-- -------------------------------------------------- 基础按键 --------------------------------------------------
-- <Alt> + m, 打开/关闭部署工具窗口
noremap('n', '<A-m>', '<cmd> lua require("configs.toggleterm.init").toggleterm_toggle("deployment") <CR>')
noremap('t', '<A-m>', '<cmd> lua require("configs.toggleterm.init").toggleterm_toggle("deployment") <CR>')
-- <Alt> + o, 打开/关闭调试窗口
noremap('n', '<A-o>', '<cmd> lua require("configs.toggleterm.init").toggleterm_toggle("debug") <CR>')
noremap('t', '<A-o>', '<cmd> lua require("configs.toggleterm.init").toggleterm_toggle("debug") <CR>')
-- <Alt> + t, 打开/关闭scp窗口
noremap('n', '<A-t>', '<cmd> lua require("configs.toggleterm.init").toggleterm_toggle("termscp") <CR>')
noremap('t', '<A-t>', '<cmd> lua require("configs.toggleterm.init").toggleterm_toggle("termscp") <CR>')
