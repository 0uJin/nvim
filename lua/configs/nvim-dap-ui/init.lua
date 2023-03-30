local status, _ = pcall(require, 'dap')
if not status then
    return
end

local dap = require('dap')
local dapui = require("dapui")
local nvim = vim

-- Golang 调试器
dap.adapters.delve = {
    type = 'server',
    port = '${port}',
    executable = {
        command = 'dlv',
        args = { 'dap', '-l', '127.0.0.1:${port}' },
    }
}
-- https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_dap.md
dap.configurations.go = {
    {
        type = "delve",
        name = "Debug",
        request = "launch",
        program = "${file}"
    },
    -- {
    --     type = "delve",
    --     name = "Debug test", -- configuration for debugging test files
    --     request = "launch",
    --     mode = "test",
    --     program = "${file}"
    -- },
    -- -- works with go.mod packages and sub packages
    -- {
    --     type = "delve",
    --     name = "Debug test (go.mod)",
    --     request = "launch",
    --     mode = "test",
    --     program = "./${relativeFileDirname}"
    -- }
}

-- Python 调试器
dap.adapters.python = {
    type = 'executable',
    command = 'python3.9',
    args = { '-m', 'debugpy.adapter' },
}
dap.configurations.python = {
    {
        -- The first three options are required by nvim-dap
        type = 'python', -- the type here established the link to the adapter definition: `dap.adapters.python`
        request = 'launch',
        name = "Launch file",
        -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

        program = "${file}", -- This configuration will launch the current file if used.
        pythonPath = function()
            -- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
            -- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
            -- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
            local cwd = nvim.fn.getcwd()
            if nvim.fn.executable(cwd .. '/venv/bin/python3') == 1 then
                return cwd .. '/venv/bin/python3'
            elseif nvim.fn.executable(cwd .. '/.venv/bin/python3') == 1 then
                return cwd .. '/.venv/bin/python3'
            else
                return 'python3'
            end
        end,
    },
}

-- C/C++/Rust 调试器
dap.adapters.lldb = {
    type = 'executable',
    command = 'lldb-vscode', -- adjust as needed, must be absolute path
    name = 'lldb'
}
dap.configurations.rust = {
    {
        name = 'Launch',
        type = 'lldb',
        request = 'launch',
        program = function()
            -- 设置默认调试二进制文件
            local workspaceFolderBasename = nvim.fn.fnamemodify(nvim.fn.getcwd(), ":t")
            local program = nvim.fn.input(
            'Path to executable (default: target/debug/' .. workspaceFolderBasename .. '): ', nvim.fn.getcwd() .. '/',
            'file')
            if program == nvim.fn.getcwd() .. '/' then
                program = nvim.fn.getcwd() .. "/target/debug/" .. workspaceFolderBasename
            end
            return program
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
        args = {},
        -- 💀
        -- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
        --
        --    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
        --
        -- Otherwise you might get the following error:
        --
        --    Error on launch: Failed to attach to the target process
        --
        -- But you should be aware of the implications:
        -- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
        -- runInTerminal = false,
    },
}

-- If you want to use this for Rust and C, add something like this:

dap.configurations.c = dap.configurations.rust
dap.configurations.cpp = dap.configurations.rust

-- ui配置
require("dapui").setup({
    icons = { expanded = "▾", collapsed = "▸", current_frame = "▸" },
    mappings = {
        -- Use a table to apply multiple mappings
        expand = { "<CR>", "o", "<2-LeftMouse>" },
        open = "<C-o>",
        remove = "dd",
        edit = "e",
        repl = "r",
        toggle = "t",
    },
    -- Expand lines larger than the window
    -- Requires >= 0.7
    expand_lines = nvim.fn.has("nvim-0.7"),
    -- Layouts define sections of the screen to place windows.
    -- The position can be "left", "right", "top" or "bottom".
    -- The size specifies the height/width depending on position. It can be an Int
    -- or a Float. Integer specifies height/width directly (i.e. 20 lines/columns) while
    -- Float value specifies percentage (i.e. 0.3 - 30% of available lines/columns)
    -- Elements are the elements shown in the layout (in order).
    -- Layouts are opened in order so that earlier layouts take priority in window sizing.
    layouts = {
        {
            elements = {
                -- Elements can be strings or table with id and size keys.
                { id = "stacks",      size = 0.1225 },
                { id = "breakpoints", size = 0.1225 },
                { id = "watches",     size = 0.305 },
                { id = "scopes",      size = 0.45 },
            },
            size = 0.20, -- 40 columns
            position = "right",
        },
        {
            elements = {
                "repl",
                -- "console", -- 暂时不显示控制台
            },
            size = 0.25, -- 25% of total lines
            position = "bottom",
        },
    },
    controls = {
        -- Requires Neovim nightly (or 0.8 when released)
        enabled = true,
        -- Display controls in this element
        element = "repl",
        icons = {
            pause = "",
            play = "",
            step_into = "",
            step_over = "",
            step_out = "",
            step_back = "",
            run_last = "↻",
            terminate = "□",
        },
    },
    floating = {
        max_height = nil,  -- These can be integers or a float between 0 and 1.
        max_width = nil,   -- Floats will be treated as percentage of your screen.
        border = "single", -- Border style. Can be "single", "double" or "rounded"
        mappings = {
            close = { "q", "<Esc>" },
        },
    },
    windows = { indent = 1 },
    render = {
        max_type_length = nil, -- Can be integer or nil.
        max_value_lines = 100, -- Can be integer or nil.
    }
})

-- 自动开启/关闭ui画面
dap.listeners.after.event_initialized["dapui_config"] = function()
    -- 隐藏[dap-repl]buffer
    local buf = nvim.api.nvim_get_current_buf()
    nvim.api.nvim_buf_set_option(buf, 'buflisted', false)
    nvim.opt.mouse = 'nvi' -- 启动鼠标
    dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
    nvim.opt.mouse = '' -- 禁用鼠标
    dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
    nvim.opt.mouse = '' -- 禁用鼠标
    dapui.close()
end

-- ====================================================  图标样式  ====================================================
require('configs.nvim-dap-ui.icons')

-- ====================================================  键盘映射  ====================================================
require('configs.nvim-dap-ui.keymaps')
