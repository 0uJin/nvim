local status, _ = pcall(require, 'notify')
if not status then
    return
end

local nvim = vim
local notify = require('notify')

local config = {
    background_colour = "Normal",
    fps = 30,
    icons = {
        DEBUG = "",
        ERROR = "",
        INFO = "",
        TRACE = "✎",
        WARN = ""
    },
    level = 2,
    minimum_width = 50,
    max_width = 100,
    render = "default",           -- default | minimal
    stages = "fade_in_slide_out", -- fade_in_slide_out | fade | slide | static
    timeout = 5000,
    hide_from_history = false,
}

notify.setup(config)

nvim.notify = notify

-- -- You can also use plenary's async library to avoid using callbacks:
-- local async = require("plenary.async")
-- local notify = require("notify").async
--
-- async.run(function()
--   notify("Let's wait for this to close").events.close()
--   notify("It closed!")
-- end)

require("telescope").load_extension("notify")

-- ====================================================  颜色高亮  ====================================================
require('configs.nvim-notify.colors')

-- ====================================================  进度展示  ====================================================
require('configs.nvim-notify.progress')

-- ====================================================  功能行为  ====================================================
require('configs.nvim-notify.action')

-- ====================================================  键盘映射  ====================================================
require('configs.nvim-notify.keymaps')
