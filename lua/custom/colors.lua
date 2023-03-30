-- ################################################## 高亮配色 ##################################################
local nvim = vim
local monokai = require('colors.monokai')

-- ========================================== nvim_set_hl: 设置高亮颜色 =========================================
-- nvim.api.nvim_set_hl({namespace_id}, {name}, {options})
--
--  options: Highlight definition map, accepts the following keys:
--      • fg (or foreground): color name or "#RRGGBB", see note.
--      • bg (or background): color name or "#RRGGBB", see note.
--      • sp (or special): color name or "#RRGGBB"
--      • blend: integer between 0 and 100
--      • bold: boolean
--      • standout: boolean
--      • underline: boolean
--      • undercurl: boolean
--      • underdouble: boolean
--      • underdotted: boolean
--      • underdashed: boolean
--      • strikethrough: boolean
--      • italic: boolean
--      • reverse: boolean
--      • nocombine: boolean
--      • link: name of another highlight group to link to, see |:hi-link|.
--      • default: Don't override existing definition |:hi-default|
--      • ctermfg: Sets foreground of cterm color |ctermfg|
--      • ctermbg: Sets background of cterm color |ctermbg|
--      • cterm: cterm attribute map, like |highlight-args|. If not set, cterm attributes will match those from the attribute map documented above.

-- ===================================== set_tab_highlight: 设置页签高亮颜色 ====================================
local function set_tab_highlight()
    -- 页签整体背景
    -- nvim.api.nvim_set_hl(0, 'TabLineFill', {fg='#262626', bg='#000000'})
    -- 未激活页签
    nvim.api.nvim_set_hl(0, 'TabLine', { fg = '#8a8a8a', bg = '#262626' })
    -- 已激活页签
    nvim.api.nvim_set_hl(0, 'TabLineSel', { fg = '#ffffff', bg = '#585858' })
    -- 文件树滚动条
    nvim.api.nvim_set_hl(0, 'VertSplit', { fg = '#000000', bg = 'NONE' })
end

-- ================================ set_diffthis_highlight: 设置文件对比高亮颜色 ================================
-- diffthis(nvim自带)显示
local function set_diffthis_highlight()
    -- 边栏显示
    nvim.api.nvim_set_hl(0, 'Folded', { ctermfg = 242, ctermbg = 235, fg = '#75715e' })
    nvim.api.nvim_set_hl(0, 'FoldColumn', { ctermfg = 51, fg = '#00fffe' })
end

-- ================================== set_document_highlight: 设置文档高亮颜色 ==================================
local function set_document_highlight()
    -- 代码停留高亮
    nvim.api.nvim_set_hl(0, 'LspReferenceText', { fg = '#262626', bg = '#87ffd7' })
end

-- ========================= set_nvim_treesitter_highlight: 重置nvim-treesitter高亮颜色 =========================
local function set_nvim_treesitter_highlight()
    -- ------------------------------------------------- golang -------------------------------------------------
    -- 内置常数
    nvim.api.nvim_set_hl(0, '@constant.builtin', { fg = '#0087ff' })
    -- 内置函数
    nvim.api.nvim_set_hl(0, '@function.builtin', { fg = '#87d7ff' })
    -- 结构体、接口类型
    nvim.api.nvim_set_hl(0, '@type.definition', { fg = '#afff00' })
    -- 转义符号, \n \t
    nvim.api.nvim_set_hl(0, 'SpecialChar', { fg = '#af87ff' })
    -- 分隔号、括号
    nvim.api.nvim_set_hl(0, 'Delimiter', { fg = '#cccccc' })
    -- String
    nvim.api.nvim_set_hl(0, 'String', { fg = '#ffff87' })
    -- 自定义函数
    nvim.api.nvim_set_hl(0, '@function', { fg = '#f0ff5f' })
    -- 结构体函数调用 Anime.anime()
    nvim.api.nvim_set_hl(0, '@method', { fg = '#87d7ff' })
    -- 内置类型
    nvim.api.nvim_set_hl(0, '@type', { fg = '#00ff87' })
    -- 函数参数
    nvim.api.nvim_set_hl(0, '@parameter', { fg = '#87ffd7' })
    -- 结构体字段
    nvim.api.nvim_set_hl(0, '@field', { fg = '#dddddd' })
    -- 常量、变量
    nvim.api.nvim_set_hl(0, '@variable', { fg = '#eeeeee' })

    -- 警告
    nvim.api.nvim_set_hl(0, 'TSDanger', { fg = '#f70000' })
end

-- ================================================== 设置配色 ==================================================
nvim.cmd('syntax enable')
nvim.opt.termguicolors = true

-- 设置monokai配色
monokai.init_highlight()

set_tab_highlight()
set_diffthis_highlight()
set_document_highlight()
set_nvim_treesitter_highlight()
