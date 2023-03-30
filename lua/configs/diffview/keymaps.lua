-- ################################################## 按键映射 ##################################################
local nvim = vim
local keymaps = require('custom.keymaps')
local noremap = keymaps.noremap
local elements = {}


elements.diffview_toggle_status = 'DiffviewOpen'
elements.diffview_file_history_toggle_status = 'DiffviewFileHistory'
elements.diffview_current_file_history_toggle_status = 'DiffviewFileHistory %'

nvim.cmd(
'autocmd User DiffviewViewOpened lua require("configs.diffview.keymaps").diffview_toggle_status="DiffviewClose" ')
nvim.cmd(
'autocmd User DiffviewViewOpened lua require("configs.diffview.keymaps").diffview_file_history_toggle_status="DiffviewClose" ')
nvim.cmd(
'autocmd User DiffviewViewOpened lua require("configs.diffview.keymaps").diffview_current_file_history_toggle_status="DiffviewClose" ')
nvim.cmd(
'autocmd User DiffviewViewClosed lua require("configs.diffview.keymaps").diffview_toggle_status="DiffviewOpen" ')
nvim.cmd(
'autocmd User DiffviewViewClosed lua require("configs.diffview.keymaps").diffview_file_history_toggle_status="DiffviewFileHistory" ')
nvim.cmd(
'autocmd User DiffviewViewClosed lua require("configs.diffview.keymaps").diffview_current_file_history_toggle_status="DiffviewFileHistory %" ')

-- 实现Diffview的Toggle功能
elements.diffview_toggle = function()
    nvim.cmd(elements.diffview_toggle_status)
end

-- 实现DiffviewFileHistory的Toggle功能
elements.diffview_file_history_toggle = function()
    nvim.cmd(elements.diffview_file_history_toggle_status)
end

-- 实现DiffviewFileHistory % 的Toggle功能
elements.diffview_current_file_history_toggle = function()
    nvim.cmd(elements.diffview_current_file_history_toggle_status)
end

-- -------------------------------------------------- 基础按键 --------------------------------------------------
-- <Alt> + g, 打开/关闭代码对比
noremap('', '<A-g>', '<cmd> lua require("configs.diffview.keymaps").diffview_toggle() <CR>')
-- <Alt> + h, 打开/关闭git历史代码对比
noremap('', '<A-h>', '<cmd> lua require("configs.diffview.keymaps").diffview_file_history_toggle() <CR>')
-- <Alt> + H, 打开/关闭当前文件git历史代码对比
noremap('', '<A-H>', '<cmd> lua require("configs.diffview.keymaps").diffview_current_file_history_toggle() <CR>')

-- ================================================ 返回通用元素 ================================================
return elements
