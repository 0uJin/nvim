-- ################################################## 按键映射 ##################################################
local keymaps = require('custom.keymaps')
local noremap = keymaps.noremap

-- -------------------------------------------------- 基础按键 --------------------------------------------------
-- <Alt> + b, 打开代码编程工具弹窗
noremap('n', '<A-b>', '<cmd> lua require("configs.nui.code-menu").open() <CR>')
-- <Alt> + p, 打开插件管理弹窗
noremap('n', '<A-p>', '<cmd> lua require("configs.nui.plugins-menu").open() <CR>')
