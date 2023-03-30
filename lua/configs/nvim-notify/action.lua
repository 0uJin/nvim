local nvim = vim
local elements = {}
local spinner = require('configs.nvim-notify.spinner')

local tomato_interval = 25
local animation_tomato_notify = { enable = false }

-- 自定义番茄时钟
elements.animation_tomato_clock = function()
    if elements.tomato_clock and not animation_tomato_notify.enable then
        local old_notify = nvim.notify(string.format("开始计时%d分钟", tomato_interval), "info", {
            title = string.format("番茄时钟\t%d分钟", tomato_interval),
            timeout = false,
            hide_from_history = false,
            on_open = function(win)
                local buf = nvim.api.nvim_win_get_buf(win)
                nvim.api.nvim_buf_set_option(buf, "filetype", "lua") -- 也可以使用其他语言高亮文本
            end,
        })
        local spinner_index = (tomato_interval * 60 * 10) % #spinner.spinner_frames
        animation_tomato_notify = {
            notification = old_notify,
            icon = spinner.spinner_frames[spinner_index],
            enable = true,
        }
        elements.update_tomato_clock(tomato_interval * 60 * 10)
    else
        nvim.notify("Complete", "error", {
            icon = "",
            title = "停止番茄时钟",
            timeout = 2 * 1000,
            hide_from_history = false,
            replace = animation_tomato_notify.notification,
        })
        animation_tomato_notify = { enable = false }
    end
end

elements.update_tomato_clock = function(count)
    if animation_tomato_notify and animation_tomato_notify.enable then
        if count > 0 then
            local new_notify = nvim.notify(string.format("还剩 %0.1f 秒钟\t %d分钟", count / 10,
                math.ceil(count / 10 / 60)), "info", {
                icon = animation_tomato_notify.icon,
                replace = animation_tomato_notify.notification,
                hide_from_history = false,
            })
            count = count - 1
            local new_spinner = count % #spinner.spinner_frames
            animation_tomato_notify = {
                icon = spinner.spinner_frames[new_spinner],
                notification = new_notify,
                enable = true,
            }
            nvim.defer_fn(function()
                elements.update_tomato_clock(count)
            end, 100)
        else
            nvim.notify("Complete", "error", {
                icon = "",
                replace = animation_tomato_notify.notification,
                timeout = 3 * 1000,
                hide_from_history = false,
            })
            animation_tomato_notify = { enable = false }
        end
    end
end

elements.tomato_clock = function()
    local old_notify = nvim.notify(string.format("开始计时 %d 分钟", tomato_interval), "info", {
        title = "番茄时钟",
        timeout = 3 * 1000,
        hide_from_history = false,
        on_open = function(win)
            local buf = nvim.api.nvim_win_get_buf(win)
            nvim.api.nvim_buf_set_option(buf, "filetype", "markdown")
            local timer = nvim.loop.new_timer()
            timer:start(tomato_interval * 60 * 1000, 0, function()
                nvim.notify("Complete", "error", {
                    icon = "",
                    title = "番茄时钟",
                    timeout = 3 * 1000,
                    hide_from_history = false,
                    -- on_close = function()
                    --     nvim.notify("Problem solved", nil, { title = plugin })
                    -- end,
                })
            end)
        end,
    })
end

-- ================================================ 返回通用元素 ================================================
return elements
