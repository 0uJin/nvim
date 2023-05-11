local nvim = vim
local elements = {}

elements.default_guicursor = nvim.opt.guicursor                               -- 记录默认的光标样式
elements.custom_guicursor = "a:hor1"                                          -- 设置光标为_
nvim.api.nvim_set_hl(0, '@cursor.line', { underline = true, fg = '#00ff87' }) -- 自定义选中行高亮样式

-- 改变样式
elements.do_change = function()
    nvim.opt.guicursor = elements.custom_guicursor

    local current_bufnr = nvim.api.nvim_get_current_buf()
    if current_bufnr == nil then
        return
    end
end

-- 恢复样式
elements.do_default = function()
    nvim.opt.guicursor = elements.default_guicursor
end


-- ================================================ 返回通用元素 ================================================
return elements
