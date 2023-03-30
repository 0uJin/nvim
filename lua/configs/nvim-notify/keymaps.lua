-- ################################################## 按键映射 ##################################################
local keymaps = require('custom.keymaps')
local noremap = keymaps.noremap

-- -------------------------------------------------- 基础按键 --------------------------------------------------
-- <Leader> + t, 开始/停止动态番茄时钟
noremap('n', '<Leader>t', '<cmd> lua require("configs.nvim-notify.action").animation_tomato_clock() <CR>')
-- <Leader> + T, 开始/停止静态番茄时钟
noremap('n', '<Leader>T', '<cmd> lua require("configs.nvim-notify.action").tomato_clock() <CR>')
