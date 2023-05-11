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
            top = "Tools",
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
    close = { "<A-b>", "q", "<Esc>", "<C-c>" },
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

    local filetype = nvim.api.nvim_buf_get_option(current_bufnr, 'filetype') -- 当前buffer文件类型
    elements.menu = nil

    -- golang
    if filetype == "go" then
        elements.menu = init_menu({
            [1] = {
                content = "Import Package",
                action = function()
                    local ok, format = pcall(require, 'go.format')
                    if not ok then
                        return
                    end

                    format.goimport()
                end
            },
            [2] = {
                content = "Add Tag",
                action = function()
                    local ok, tags = pcall(require, 'go.tags')
                    if not ok then
                        return
                    end

                    tags.add()
                end
            },
            [3] = {
                content = "Remove Tag",
                action = function()
                    local ok, tags = pcall(require, 'go.tags')
                    if not ok then
                        return
                    end

                    tags.rm()
                end
            },
        })
    end

    on_open()
end

-- ================================================ 返回通用元素 ================================================
return elements
