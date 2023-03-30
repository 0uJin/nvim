local status, _ = pcall(require, 'nvim-tree')
if not status then
    return
end

local nvim = vim
local nvim_tree = require('nvim-tree')
local nvim_tree_api = require('nvim-tree.api')
local actions = require('nvim-tree.actions')


local config = {
    auto_reload_on_write = true,
    create_in_closed_folder = false,
    disable_netrw = false,
    hijack_cursor = false,
    hijack_netrw = true,
    hijack_unnamed_buffer_when_opening = false,
    -- ignore_buffer_on_setup = true, -- 启动时开始文件树
    -- open_on_setup = true, -- 启动时开启文件树
    -- auto_close = true, -- 最后一个buffer关闭时自动退出vim
    open_on_setup_file = false,
    open_on_tab = true, -- todo
    sort_by = "name",
    root_dirs = {},
    prefer_startup_root = false,
    sync_root_with_cwd = false,
    reload_on_bufenter = false,
    respect_buf_cwd = false,
    update_cwd = true, -- todo
    view = {
        adaptive_size = false,
        centralize_selection = false,
        width = 30,
        hide_root_folder = false,
        side = "left",
        preserve_window_proportions = false,
        number = false,
        relativenumber = false,
        signcolumn = "yes",
        mappings = {
            custom_only = false,
            list = {
                { key = { "<CR>", "o", "<2-LeftMouse>" }, action = "edit" },                     -- 打开文件
                { key = { "<C-e>", "q" },                 action = "close" },                    -- 关闭文件树
                -- { key = {"<C-o>", "<tab>", "<CR>"}, action = "preview" },           -- 在新buffer中打开文件
                { key = "<tab>",                          action = "preview" },                  -- 在buffer中预览文件, 新buffer会覆盖旧buffer
                { key = "<C-o>",                          action = "preview" },                  -- 在新buffer中打开文件
                { key = "<C-r>",                          action = "rename" },                   -- 文件重命名
                { key = "<C-n>",                          action = "create" },                   -- 创建文件
                { key = "<C-d>",                          action = "remove" },                   -- 移除文件
                { key = "<C-x>",                          action = "cut" },                      -- 剪切文件
                { key = "<C>",                            action = "cpoy" },                     -- 复制文件(<ctrl> + <c> 不生效)
                { key = "<C-v>",                          action = "paste" },                    -- 粘贴文件
                { key = "<C-i>",                          action = "toggle_file_info" },         -- 显示文件信息
                { key = "<C-k>",                          action = "silent_change_dir_action" }, -- 更改当前目录(联动telescope使用)
                { key = { "r", "R" },                     action = "refresh" },                  -- 刷新目录
                { key = "u",                              action = "dir_up" },                   -- 移动至前一个父目录
                { key = "?",                              action = "toggle_help" },              -- 快捷键提示
                { key = "y",                              action = "copy_name" },                -- 复制文件名
                { key = "Y",                              action = "copy_path" },                -- 复制文件路径
                { key = "S",                              action = "split" },                    -- 水平打开文件
                { key = "V",                              action = "vsplit" },                   -- 垂直打开文件
                { key = "Y",                              action = "copy_path" },                -- 复制文件路径
                { key = "<C-g>",                          action = "toggle_git_ignored" },       -- 显示/隐藏git忽略的文件
                { key = "[g",                             action = "prev_git_item" },
                { key = "]g",                             action = "next_git_item" },
                -- 快捷键置空
                {
                    key = { "I", "J", "H", "K", "O", "<2-RightMouse>", "<C-]>", "<C-t>", "<", ">", "P", "BS", "a", "d",
                        "D",
                        "gy", "-", "s", "g?", "W", "n", "N", "," },
                    action = ""
                },
            }
        },
    },
    renderer = {
        add_trailing = false,
        group_empty = false,
        full_name = false,
        highlight_git = true, -- 高亮有变化的git文件夹
        highlight_opened_files = "none",
        root_folder_modifier = ":~",
        indent_markers = {
            enable = false,
            icons = {
                corner = "└ ",
                edge = "│ ",
                item = "│ ",
                none = "  ",
            },
        },
        icons = {
            webdev_colors = true,
            git_placement = "before",
            padding = " ",
            symlink_arrow = " ➛ ",
            show = {
                file = true,
                folder = true,
                folder_arrow = true,
                git = true,
            },
            glyphs = {
                default = "",
                symlink = "",
                folder = {
                    arrow_closed = "",
                    arrow_open = "",
                    default = "",
                    open = "",
                    empty = "",
                    empty_open = "",
                    symlink = "",
                    symlink_open = "",
                },
                git = {
                    unstaged = "ﲅ",
                    staged = "",
                    unmerged = "",
                    renamed = "北",
                    untracked = "ﭐ",
                    deleted = "ﭏ",
                    ignored = "◌",
                },
            },
        },
        special_files = { "Cargo.toml", "Makefile", "README.md" }, -- 高亮显示文件
    },
    hijack_directories = {
        enable = true,
        auto_open = true,
    },
    update_focused_file = {
        enable      = true,
        update_root = true,
        update_cwd  = true,
        ignore_list = { "term", 'DiffviewFiles', 'DiffviewFileHistory' },
    },
    ignore_ft_on_setup = {},
    system_open = {
        cmd = "",
        args = {},
    },
    diagnostics = {
        enable = false,
        show_on_dirs = false,
        icons = {
            hint = "",
            info = "",
            warning = "",
            error = "",
        },
    },
    filters = {
        dotfiles = false,
        custom = { ".git$" },      -- 隐藏.git文件夹
        exclude = { ".gitignore" } -- .gitignore生效
    },
    filesystem_watchers = {
        enable = false,
        debounce_delay = 100,
    },
    git = {
        enable = true,
        ignore = true,
        timeout = 500,
    },
    actions = {
        use_system_clipboard = true,
        change_dir = {
            enable = true,
            global = false,
            restrict_above_cwd = false,
        },
        expand_all = {
            max_folder_discovery = 300,
        },
        open_file = {
            quit_on_open = false,
            resize_window = false,
            window_picker = {
                enable = true,
                chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
                exclude = {
                    filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
                    buftype = { "nofile", "terminal", "help" },
                },
            },
        },
        remove_file = {
            close_window = true,
        },
    },
    trash = {
        cmd = "gio trash",
        require_confirm = true,
    },
    live_filter = {
        prefix = "[FILTER]: ",
        always_show_folders = true,
    },
    log = {
        enable = false,
        truncate = false,
        types = {
            all = false,
            config = false,
            copy_paste = false,
            diagnostics = false,
            git = false,
            profile = false,
            watcher = false,
        },
    },
}

local silent_change_dir_action = function(node)
    local path = node.absolute_path
    if node.link_to and not node.nodes then
        path = node.link_to
    end

    -- directory, 节点类型为文件夹时, 直接使用当前的路径
    -- file, 节点类型为文件时, 当前路径进行裁切
    if node.type == "file" then
        path = nvim.fn.fnamemodify(path, ":p:h")
        -- path = path:match("(.*/)") -- 等效 nvim.fn.fnamemodify(path, ":p:h")
    end
    nvim.cmd(string.format("silent lcd %s", path)) -- 更改当前路径, telescope查询目录也随之改变
end

actions.custom_keypress_funcs = {
    silent_change_dir_action = silent_change_dir_action,
}


nvim_tree.setup(config)

nvim_tree_api.tree.open()

-- ====================================================  键盘映射  ====================================================
require('configs.nvim-tree.keymaps')
