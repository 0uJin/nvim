-- ################################################## 按键映射 ##################################################
local keymaps = require('custom.keymaps')
local noremap = keymaps.noremap

-- -------------------------------------------------- 基础按键 --------------------------------------------------
-- <Alt> + b, 打开工具弹窗
noremap('n', '<A-b>', '<cmd> lua require("configs.nui.menu").open() <CR>')

