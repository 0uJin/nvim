local nvim = vim
local elements = {}

elements.client_notifs = {}
elements.spinner_frames = { '⣾', '⣽', '⣻', '⢿', '⡿', '⣟', '⣯', '⣷' }

elements.update_spinner = function(client_id, token)
    local notif_data = elements.client_notifs[client_id][token]
    if notif_data and notif_data.spinner then
        local new_spinner = (notif_data.spinner + 1) % #elements.spinner_frames
        local new_notif = nvim.notify(
            nil,
            nil,
            { hide_from_history = true, icon = elements.spinner_frames[new_spinner], replace = notif_data.notification }
        )
        elements.client_notifs[client_id][token] = {
            notification = new_notif,
            spinner = new_spinner,
        }
        nvim.defer_fn(function()
            elements.update_spinner(client_id, token)
        end, 100)
    end
end

elements.format_title = function(title, client_name)
    return client_name .. (#title > 0 and ': ' .. title or '')
end

elements.format_message = function(message, percentage)
    return (percentage and percentage .. '%\t' or '') .. (message or '')
end

-- ================================================ 返回通用元素 ================================================
return elements
