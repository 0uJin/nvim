-- ################################################## 按键映射 ##################################################
local keymaps = require('custom.keymaps')
local noremap = keymaps.noremap

-- -------------------------------------------------- 基础按键 --------------------------------------------------
-- <Ctrl> + f, 查找文件
noremap('n', '<C-f>', '<cmd> lua require("telescope.builtin").find_files() <CR>')
-- <Alt> + f, 搜索项目中的内容
noremap('n', '<A-f>', '<cmd> lua require("telescope.builtin").live_grep() <CR>')
-- <Alt> + <Shift> + f, 搜索(选中内容在)项目中的位置
noremap('n', '<A-F>', '<cmd> lua require("telescope.builtin").grep_string() <CR>')
-- <Ctrl> + g, 列出项目中全部的错误
noremap('n', '<C-g>', '<cmd> lua require("telescope.builtin").diagnostics() <CR>')
-- <Ctrl> + u, 查询函数被引用情况
noremap('n', '<C-u>', '<cmd> lua require("telescope.builtin").lsp_references() <CR>')
-- <Ctrl> + k, 根据选中的[参数]、[函数]跳转(打开新buffer页)
noremap('n', '<C-k>', '<cmd> lua require("telescope.builtin").lsp_definitions() <CR>')
-- <Ctrl> + b, 列出所有mark标记
noremap('n', '<C-b>', '<cmd> lua require("telescope.builtin").marks() <CR>')
