local nvim = vim
local hide_from_history = false
local spinner = require('configs.nvim-notify.spinner')

-- 展示编译器加载进度
nvim.lsp.handlers['$/progress'] = function(_, result, ctx)
    local client_id = ctx.client_id
    local val = result.value
    if val.kind then
        if not spinner.client_notifs[client_id] then
            spinner.client_notifs[client_id] = {}
        end
        local notif_data = spinner.client_notifs[client_id][result.token]
        if val.kind == 'begin' then
            local client = nvim.lsp.get_client_by_id(client_id)
            local client_name = ''
            local level = 'info'
            if client ~= nil then
                client_name = client.name
                -- gopls 单独处理(gopls: Error loading workspace, 不会消失, 需要做下特殊处理)
                if client_name == 'gopls' and val.title ~= nil and val.title == 'Error loading workspace' then
                    level = 'error'
                    nvim.loop.new_timer():start(3000, 0, function()
                        local old_notify = spinner.client_notifs[client_id][result.token]
                        local new_notif = nvim.notify(
                            val.message and spinner.format_message(val.message),
                            level,
                            { icon = '', replace = old_notify.notification, timeout = 3000 }
                        )
                        spinner.client_notifs[client_id][result.token] = {
                            notification = new_notif,
                            level = level,
                        }
                    end)
                end
            end

            local message = spinner.format_message(val.message, val.percentage)
            local notification = nvim.notify(message, level, {
                title = spinner.format_title(val.title, client_name),
                icon = spinner.spinner_frames[1],
                timeout = false,
                hide_from_history,
            })
            spinner.client_notifs[client_id][result.token] = {
                notification = notification,
                level = level,
                spinner = 1,
            }
            spinner.update_spinner(client_id, result.token)
        elseif val.kind == 'report' and notif_data then
            local new_notif = nvim.notify(
                spinner.format_message(val.message, val.percentage),
                notif_data.level,
                { replace = notif_data.notification, hide_from_history = false }
            )
            spinner.client_notifs[client_id][result.token] = {
                notification = new_notif,
                level = notif_data.level,
                spinner = notif_data.spinner,
            }
        elseif val.kind == 'end' and notif_data then
            local new_notif = nvim.notify(
                val.message and spinner.format_message(val.message) or 'Complete',
                notif_data.level,
                { icon = '', replace = notif_data.notification, timeout = 3000 }
            )
            spinner.client_notifs[client_id][result.token] = {
                notification = new_notif,
                level = notif_data.level,
            }
        end
    end
end
