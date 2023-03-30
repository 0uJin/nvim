local status, _ = pcall(require, 'lspsaga')
if not status then
    return
end

local lspsaga = require('lspsaga')

lspsaga.setup(
    {
        -- 提示边框样式：round、single、double
        border_style = 'round',
        use_diagnostic_virtual_text = false,
        error_sign = '',
        warn_sign = '',
        hint_sign = '',
        infor_sign = '',
        diagnostic_header_icon = '',
        -- 正在写入的行提示
        code_action_icon = '',
        code_action_prompt = {
            -- 显示写入行提示
            -- 如果为 true ，则写代码时会在左侧行号栏中显示你所定义的图标
            enable = false,
            sign = true,
            sign_priority = 40,
            virtual_text = false
        },
        -- 快捷键配置
        code_action_keys = {
            quit = '<Esc>',
            exec = '<CR>'
        },
        rename_action_keys = {
            quit = '<Esc>',
            exec = '<CR>'
        }
    }
)
