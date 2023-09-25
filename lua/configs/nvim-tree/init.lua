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
    -- open_on_setup_file = false,
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
        side = "left",
        preserve_window_proportions = false,
        number = false,
        relativenumber = false,
        signcolumn = "yes",
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
    -- ignore_ft_on_setup = {},
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


-- ====================================================  键盘映射  ====================================================
local keymaps = require('configs.nvim-tree.keymaps')


config.on_attach = keymaps.on_attach
nvim_tree.setup(config)

nvim_tree_api.tree.open()
