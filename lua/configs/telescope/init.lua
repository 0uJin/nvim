local status, _ = pcall(require, 'telescope')
if not status then
    return
end

local telescope = require('telescope')
-- local actions = require('telescope.actions')
local generate = require("telescope.actions.generate")

telescope.setup {
    defaults = {
        layout_strategy = 'vertical',
        layout_config = {
            height = 0.95,
            width = 0.8,
        },
        -- 按键映射
        mappings = {
            -- 插入模式
            i = {
                ["<esc>"] = require('telescope.actions').close,
                ["<C-c>"] = require('telescope.actions').close,
                ["<tab>"] = require('telescope.actions').move_selection_previous, -- 覆盖原先tab键功能(<tab> 与 <C-i> ascii码一致)
                ["<C-i>"] = require('telescope.actions').move_selection_previous,
                -- ["<C-i>"] = actions.move_selection_previous,
                -- ["<C-i>"] = "move_selection_previous",
                ["<C-k>"] = require('telescope.actions').move_selection_next,
                -- ["<C-k>"] = actions.move_selection_next,
                -- ["<C-k>"] = "move_selection_next",
                ["<A-i>"] = require('telescope.actions').preview_scrolling_up,
                ["<A-k>"] = require('telescope.actions').preview_scrolling_down,
                ["C-n"] = false, -- 禁用按键
                ["C-p"] = false, -- 禁用按键
                ["C-u"] = false,
                ["<A-q>"] = require('telescope.actions').send_to_qflist + require('telescope.actions').open_qflist,
                -- ["C-h"] = require('telescope.actions').set_command_line,
                --
                -- <Ctrl> + <Esc> 进入普通模式
                --
                -- 在指定的子集中查找(层层筛选)
                -- 例:
                -- 指定在文件夹 (/usr/local/neovim) 中查找内容时
                -- 1. 输入第一层过滤内容: usr/local/neovim + <Ctrl> + <Space>
                -- (此时查找目录被限定在 /usr/local/neovim 中)
                -- 2. 再输入要查找的内容: local + <Ctrl> + <Sapce>
                -- ["<C-Space>"] = actions.to_fuzzy_refine, -- 实现方式1
                ["<C-Space>"] = function(prompt_bufnr)
                    generate.refine(prompt_bufnr, {
                        prompt_to_prefix = true,
                        sorter = false,
                    })
                end, -- 实现方式2
            },
            -- 普通模式
            n = {
                ["H"] = false,
                ["M"] = false,
                ["L"] = false,
                ["j"] = false,
                ["i"] = require('telescope.actions').move_selection_previous,
                ["k"] = require('telescope.actions').move_selection_next,
            }
        },
        -- vimgrep_arguments
        vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--column",
            "--line-number",
            "--smart-case"
        },
        -- 忽略文件
        -- file_ignore_patterns = { "go.mod", "go.sum", ".git/*" } -- .git/* 存在问题
        file_ignore_patterns = { "go.mod", "go.sum" }
    },
    pickers = {
        -- Default configuration for builtin pickers goes here:
        -- picker_name = {
        --   picker_config_key = value,
        --   ...
        -- }
        -- Now the picker_config_key will be applied every time you call this
        -- builtin picker
        find_files = {
            -- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
            find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
        },
    },
    extensions = {
        -- Your extension configuration goes here:
        -- extension_name = {
        --   extension_config_key = value,
        -- }
        -- please take a look at the readme of the extension you want to configure
    }
}

-- ====================================================  颜色高亮  ====================================================
require('configs.telescope.colors')

-- ====================================================  键盘映射  ====================================================
require('configs.telescope.keymaps')
