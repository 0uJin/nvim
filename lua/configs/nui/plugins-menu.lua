local status, menu = pcall(require, 'nui.menu')
if not status then
    return
end

local nvim = vim
local elements = {}
local style = require('configs.nui.style')

local default_popup_options = {
    position = "50%",
    size = {
        width = 25,
        -- height = 5,
    },
    border = {
        style = "rounded",
        text = {
            top = "Plugins Tools",
            top_align = "center",
        },
    },
    win_options = {
        winhighlight = "FloatBorder:Normal,CursorLine:@cursor.line", -- 自定义打开窗口样式
    },
}

local default_keymap = {
    focus_prev = { "i", "<Up>", "<S-Tab>" },
    focus_next = { "k", "<Down>", "<Tab>" },
    close = { "<A-p>", "q", "<Esc>", "<C-c>" },
    submit = { "<CR>", "<Space>" },
}

-- 开启menu时触发的函数
local on_open = function()
    if elements.menu == nil then
        return
    end

    style.do_change() -- 改变样式
    elements.menu:mount()
end

-- 关闭menu时触发的函数
local on_close = function()
    style.do_default() -- 样式还原
end

-- 初始化menu
local init_menu = function(menu_items)
    if type(menu_items) ~= "table" then
        return
    end

    local lines = {}

    for index, item in pairs(menu_items) do
        if not item or not item.content then
            goto continue
        end

        local data   = { text = item.content, id = index }
        lines[index] = menu.item(item.content, data)

        :: continue ::
    end


    local on_submit = function(line)
        local item = menu_items[line.id]
        if not item or not item.action then
            return
        end

        item.action()
        style.do_default() -- 样式还原
    end

    return menu(default_popup_options, {
        lines = lines,
        on_submit = on_submit,
        on_close = on_close,
        max_width = 20,
        keymap = default_keymap,
    })
end


elements.open = function()
    local current_bufnr = nvim.api.nvim_get_current_buf()
    if current_bufnr == nil then
        return
    end

    elements.menu = nil
    elements.menu = init_menu({
        -- lazy.nvim 插件管理工具
        [1] = {
            content = "Lazy",
            action = function()
                nvim.cmd("Lazy")
            end
        },
        -- mason.nvim lsp管理工具
        [2] = {
            content = "Mason",
            action = function()
                nvim.cmd("Mason")
            end
        },
        -- nvim-treesitter 更新代码文本样式
        [3] = {
            content = "TSUpdateSync",
            action = function()
                nvim.cmd("TSUpdateSync")
            end
        },
    })

    on_open()
end

-- ================================================ 返回通用元素 ================================================
return elements
