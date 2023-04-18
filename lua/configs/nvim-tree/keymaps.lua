-- ################################################## 按键映射 ##################################################
local nvim = vim
local keymaps = require('custom.keymaps')
local noremap = keymaps.noremap
local elements = {}
local api = require('nvim-tree.api')

-- -------------------------------------------------- 基础按键 --------------------------------------------------
-- <Ctrl> + e, 打开/关闭文件树
noremap('n', '<C-e>', ':NvimTreeToggle <CR>')

elements.on_attach = function(bufnr)
    local options = function(desc)
        return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    nvim.keymap.set('n', 'o', api.node.open.edit, options('打开文件'))
    nvim.keymap.set('n', '<2-LeftMouse>', api.node.open.edit, options('打开文件'))
    nvim.keymap.set('n', '<CR>', api.node.open.edit, options('打开文件'))
    nvim.keymap.set('n', 'q', api.tree.close, options('关闭文件树'))
    nvim.keymap.set('n', '<Tab>', api.node.open.preview, options('在buffer中预览文件')) -- 新buffer会覆盖旧buffer
    nvim.keymap.set('n', '<C-r>', api.fs.rename, options('文件重命名'))
    nvim.keymap.set('n', '<C-n>', api.fs.create, options('创建文件'))
    nvim.keymap.set('n', '<C-d>', api.fs.remove, options('移除文件'))
    nvim.keymap.set('n', '<C-c>', api.fs.copy.node, options('复制文件'))
    nvim.keymap.set('n', '<C-x>', api.fs.cut, options('剪切文件'))
    nvim.keymap.set('n', '<C-v>', api.fs.paste, options('粘贴文件'))
    nvim.keymap.set('n', '<C-i>', api.node.show_info_popup, options('显示文件信息'))
    nvim.keymap.set('n', '<C-o>', api.tree.change_root_to_parent, options('移动至前一个父目录'))
    nvim.keymap.set('n', '<C-k>', api.tree.change_root_to_node, options('更改当前目录'))
    nvim.keymap.set('n', 'r', api.tree.reload, options('刷新目录'))
    nvim.keymap.set('n', 'y', api.fs.copy.filename, options('复制文件名'))
    nvim.keymap.set('n', 'Y', api.fs.copy.relative_path, options('复制文件路径'))
    nvim.keymap.set('n', 'S', api.node.open.horizontal, options('水平打开文件'))
    nvim.keymap.set('n', 'V', api.node.open.vertical, options('垂直打开文件'))
    nvim.keymap.set('n', '<C-h>', api.tree.toggle_hidden_filter, options('显示/隐藏隐藏文件'))
    nvim.keymap.set('n', '<C-g>', api.tree.toggle_gitignore_filter, options('显示/隐藏git忽略的文件'))
    nvim.keymap.set('n', '[g', api.node.navigate.git.prev, options('定位到上一个git状态不同的文件'))
    nvim.keymap.set('n', ']g', api.node.navigate.git.next, options('定位到下一个git状态不同的文件'))
    nvim.keymap.set('n', '?', api.tree.toggle_help, options('帮助信息'))
end

return elements
