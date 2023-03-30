local status, _ = pcall(require, 'toggleterm')
if not status then
    return
end

local nvim = vim
local elements = {}

local toggleterm_config = require('toggleterm.config')
local config = toggleterm_config.get()
-- 命令运行完成状态是否自动关闭窗口, true: 自动关闭, false: 不自动关闭
config.close_on_exit = true

-- neovim 0.9才支持窗口命名, 目前该配置无效
config.winbar = {
    enabled = true,
    name_formatter = function(term) return string.format("%d:%s", term.id, term:_display_name()) end,
}

config.highlights = {
    -- NormalFloat = {},
    FloatBorder = {
        guifg = 'White',
    },
}

local Terminal = require('toggleterm.terminal').Terminal

-- 获取窗口大小
-- local max_width = math.ceil(math.min(vim.o.columns, math.max(80, vim.o.columns - 20)))
-- local max_height = math.ceil(math.min(vim.o.lines, math.max(20, vim.o.lines - 10)))
local max_width = math.ceil(nvim.o.columns)
local max_height = math.ceil(nvim.o.lines)


-- 设置按键映射
elements.set_terminal_keymaps = function()
    local keymaps = require('custom.keymaps')
    keymaps.buffer_map('t', '<A-i>', [[<C-\><C-n>]]) -- 进入命令模式
    keymaps.buffer_map('t', '<C-l>', [[<C-l>]])      -- <Ctrl> + l, 清屏
    keymaps.buffer_map('t', 'q', [[q]])              -- q默认为退出, 映射为q
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd('autocmd! TermOpen term://* lua require("configs.toggleterm.init").set_terminal_keymaps()')

-- 部署工具
local deployment = Terminal:new({
    cmd = "~/.config/nvim/deployment/deployment",
    dir = "",
    direction = "float",
    float_opts = {
        -- border = "single",
        -- border = "double",
        -- border = "shadow",
        border = "curved",
        height = math.ceil(max_height * 0.8),
        width = math.ceil(max_width * 0.4),
    },
    on_open = function(term)
        vim.cmd("startinsert!") -- 进入输入模式
        -- vim.api.nvim_buf_set_keymap(term.bufnr, "t", "<Esc>", "<cmd>close<CR>", {noremap = true, silent = true})
    end,
    on_close = function(term)
        -- vim.cmd("Closing terminal")
    end,
})

-- 上传工具
local termscp = Terminal:new({
    cmd = "termscp",
    dir = "",
    direction = "float",
    float_opts = {
        border = "curved",
        height = math.ceil(max_height * 0.8),
        width = math.ceil(max_width * 0.8),
    },
    on_open = function(term)
        vim.cmd("startinsert!") -- 进入输入模式
        -- vim.api.nvim_buf_set_keymap(term.bufnr, "t", "<Esc>", "<cmd>close<CR>", {noremap = true, silent = true})
    end,
    on_close = function(term)
        -- vim.cmd("Closing terminal")
    end,
})

-- 调试窗口
local debug = Terminal:new({
    cmd = "zsh",
    dir = "",
    direction = "float",
    float_opts = {
        border = "curved",
        height = math.ceil(max_height * 0.7),
        width = math.ceil(max_width * 0.8),
        winblend = 10, -- 透明度
    },
    on_open = function(term)
        vim.cmd("startinsert!") -- 进入输入模式
        -- vim.api.nvim_buf_set_keymap(term.bufnr, "t", "<Esc>", "<cmd>close<CR>", {noremap = true, silent = true})
        -- vim.api.nvim_set_keymap("t", "<A-m>", "<cmd>lua _toggleterm_deployment_toggle()<CR>", { noremap = true, silent = true })
    end,
    on_close = function(term)
        -- vim.cmd("Closing terminal")
    end,
})

local action_list = { deployment = deployment, termscp = termscp, debug = debug }

elements.toggleterm_toggle = function(action)
    for terminal_name, terminal_windows in pairs(action_list) do
        -- local echo_command = string.format("echo 'name=%s, windows=%s, action=%s, equal=%s'", terminal_name, tostring(terminal_windows:is_open()), action, tostring(terminal_name == action))
        -- vim.cmd(echo_command)
        -- 关闭其他浮窗
        if terminal_name ~= action then
            if terminal_windows:is_open() then
                terminal_windows:toggle()
                return
            end
            -- else
            --     terminal_windows:toggle()
        end
    end

    for terminal_name, terminal_windows in pairs(action_list) do
        if terminal_name == action then
            terminal_windows:toggle()
        end
    end

    -- for terminal_name, terminal_windows in pairs(action_list) do
    --     if terminal_name == action then
    --         terminal_windows:toggle()
    --     end
    -- end
end


-- ====================================================  键盘映射  ====================================================
require('configs.toggleterm.keymaps')

-- ================================================ 返回通用元素 ================================================
return elements
