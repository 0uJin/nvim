-- ################################################## 按键映射 ##################################################
local keymaps = require('custom.keymaps')
local noremap = keymaps.noremap

-- -------------------------------------------------- 基础按键 --------------------------------------------------
-- <Ctrl> + j, 向左移动
noremap('n', '<C-j>', ':BufferLineCyclePrev<CR>')
-- <Ctrl> + l, 向右移动
noremap('n', '<C-l>', ':BufferLineCycleNext<CR>')
