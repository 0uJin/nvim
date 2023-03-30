-- ################################################## 按键映射 ##################################################
local nvim = vim
local elements = {}

-- ================================================ 设置leader键 ================================================
-- 将空格设置为leader键
nvim.g.mapleader = ' '

-- ===================================== noremap: 被映射的按键不会被二次映射 ====================================
-- noremap(模式, 原始按键, 绑定按键)
-- -------------------------------------------------- 参数解释 --------------------------------------------------
-- mode:
--     ''   mapmode-nvo :noremap    Normal, Visual, Select, Operator-pending
--     'n'  mapmode-n   :nnoremap   Normal
--     'v'  mapmode-v   :vnoremap   Visual and Select
--     's'  mapmode-s   :snoremap   Select
--     'x'  mapmode-x   :xnoremap   Visual
--     'o'  mapmode-o   :onoremap   Operator-pending
--     '!'  mapmode-ic  :!noremap   Insert and Command-line
--     'i'  mapmode-i   :inoremap   Insert
--     'l'  mapmode-l   :lnoremap   Insert, Command-line, Lang-Arg
--     'c'  mapmode-c   :cnoremap   Command-line
--     't'  mapmode-t   :tnoremap   Terminal
elements.noremap = function(mode, original_key, bind_key)
    nvim.api.nvim_set_keymap(mode, original_key, bind_key, { noremap = true, silent = true })
end
local noremap = elements.noremap

-- ======================================== map: 被映射的按键会被二次映射 =======================================
-- map(模式, 原始按键, 绑定按键)
-- -------------------------------------------------- 参数解释 --------------------------------------------------
-- mode:
--     ''   mapmode-nvo :noremap    Normal, Visual, Select, Operator-pending
--     'n'  mapmode-n   :nnoremap   Normal
--     'v'  mapmode-v   :vnoremap   Visual and Select
--     's'  mapmode-s   :snoremap   Select
--     'x'  mapmode-x   :xnoremap   Visual
--     'o'  mapmode-o   :onoremap   Operator-pending
--     '!'  mapmode-ic  :!noremap   Insert and Command-line
--     'i'  mapmode-i   :inoremap   Insert
--     'l'  mapmode-l   :lnoremap   Insert, Command-line, Lang-Arg
--     'c'  mapmode-c   :cnoremap   Command-line
--     't'  mapmode-t   :tnoremap   Terminal
elements.map = function(mode, original_key, bind_key)
    nvim.api.nvim_set_keymap(mode, original_key, bind_key, { noremap = false, silent = true })
end
local map = elements.map

-- =========================================== buffer_map: 缓冲区映射 ===========================================
-- buffer_map(模式, 原始按键, 绑定按键)
-- -------------------------------------------------- 参数解释 --------------------------------------------------
-- mode:
--     ''   mapmode-nvo :noremap    Normal, Visual, Select, Operator-pending
--     'n'  mapmode-n   :nnoremap   Normal
--     'v'  mapmode-v   :vnoremap   Visual and Select
--     's'  mapmode-s   :snoremap   Select
--     'x'  mapmode-x   :xnoremap   Visual
--     'o'  mapmode-o   :onoremap   Operator-pending
--     '!'  mapmode-ic  :!noremap   Insert and Command-line
--     'i'  mapmode-i   :inoremap   Insert
--     'l'  mapmode-l   :lnoremap   Insert, Command-line, Lang-Arg
--     'c'  mapmode-c   :cnoremap   Command-line
--     't'  mapmode-t   :tnoremap   Terminal
elements.buffer_map = function(mode, original_key, bind_key)
    nvim.api.nvim_buf_set_keymap(0, mode, original_key, bind_key, { noremap = true, silent = true })
end

-- ================================================ 关闭当前页签 ================================================
elements.delete_current_buffer = function()
    local current_buffer_number = nvim.api.nvim_get_current_buf()
    local buffer_list = nvim.fn.getbufinfo({ buflisted = 1 }) -- 获取缓冲区为1的页签列表
    local buffer_number = #buffer_list                      -- 缓冲区列表总数

    if buffer_number <= 1 then
        nvim.cmd('bdelete!')             -- 页签总数<=1时, 关闭当前
    elseif current_buffer_number == buffer_list[buffer_number].bufnr then
        nvim.cmd('bprevious|bdelete! #') -- 当前页签最后一个时, 向前移动并且关闭页签
    else
        nvim.cmd('bnext|bdelete! #')     -- 向后移动并且关闭页签
    end
end

-- -------------------------------------------------- 功能按键 --------------------------------------------------
-- 开启/关闭拼写检查
map('', '<Leader>s', ':set spell! <CR>')
-- <Ctrl> + s 保存
noremap('', '<C-s>', ':w<CR>')
-- <Ctrl> + q 退出
noremap('', '<C-q>', ':q<CR>')
-- <Leader><-> 代码折叠
noremap('', '<leader>-', 'zm')
-- <Leader><=> 代码展开
noremap('', '<leader>=', 'zr')
-- - 窗口减小垂直方向
noremap('', '-', ':vertical resize -1 <CR>')
-- = 窗口增大垂直方向
noremap('', '=', ':vertical resize +1 <CR>')
-- _ 窗口减小水平方向
noremap('', '_', ':resize -1 <CR>')
-- + 窗口增大水平方向
noremap('', '+', ':resize +1 <CR>')
-- ( 折叠代码
noremap('', '(', 'zc')
-- ) 展开代码
noremap('', ')', 'zo')
-- <Ctrl> + n, 新建页签
noremap('n', '<C-n>', ':enew <CR>')
-- <Ctrl> + d, 关闭页签, 并回到上一个页签
noremap('n', '<C-d>', ':lua require("custom.keymaps").delete_current_buffer() <CR>')

-- -------------------------------------------------- 基础按键 --------------------------------------------------
-- 上
noremap('', 'i', 'k')
-- 下
noremap('', 'k', 'j')
-- 左
noremap('', 'j', 'h')
-- 右
noremap('', 'h', 'i')
-- 行首插入
noremap('', 'H', 'I')
-- 上5行
noremap('', 'I', '5k')
-- 下5行
noremap('', 'K', '5j')
-- 左5行
noremap('', 'J', '5h')
-- 右5行
noremap('', 'L', '5l')
-- q更改为:qa (误触率高)
noremap('', 'q', ':qa')
--  x操作不存储至剪切板, ("_ 黑洞寄存器)
noremap('', 'x', '"_x')

-- 向后搜索时, 将查找到的内容至于屏幕中间
-- noremap('', 'n', 'nzz')
-- 向前搜索时, 将查找到的内容至于屏幕中间
-- noremap('', 'N', 'NZZ')

-- -------------------------------------------------- 窗口移动 --------------------------------------------------
-- <Leader> + i, 向上移动neovim窗口
noremap('n', '<Leader>i', ':wincmd k <CR>')
-- <Leader> + k, 向下移动neovim窗口
noremap('n', '<Leader>k', ':wincmd j <CR>')
-- <Leader> + j, 向左移动neovim窗口
noremap('n', '<Leader>j', ':wincmd h <CR>')
-- <Leader> + l, 向右移动neovim窗口
noremap('n', '<Leader>l', ':wincmd l <CR>')

-- -------------------------------------------------- 特殊按键 --------------------------------------------------
-- 按住两下空格, 跳转到<><>, 删除<><>并进入输入模式(<><>作为靶点进行更替)
elements.search_plus_plus = function()
    if nvim.fn.search('<><>', 'w') <= 0 then
        return
    end

    local command = 'normal c4l'
    local termcode = nvim.api.nvim_replace_termcodes(command, true, true, true)
    nvim.cmd(termcode)
end
map('', '<Leader><Leader>', '<Esc>:lua require("custom.keymaps").search_plus_plus() <CR>')

-- ================================================ 返回通用元素 ================================================
return elements
