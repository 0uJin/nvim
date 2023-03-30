local status, _ = pcall(require, 'diffview')
if not status then
    return
end

local diffview_callback = require('diffview.config').diffview_callback
local diffview = require('diffview')
local gitsigns_actions = require('gitsigns.actions')
local gitsigns_config = require('gitsigns.config').config
local signcolumn = gitsigns_config.signcolumn -- 记录gitsigns显示状态


diffview.setup {
    diff_binaries = false,    -- Show diffs for binaries
    enhanced_diff_hl = false, -- See ':h diffview-config-enhanced_diff_hl'
    use_icons = true,         -- Requires nvim-web-devicons
    icons = {
        -- Only applies when use_icons is true.
        folder_closed = "",
        folder_open = "",
    },
    view = {
        -- Configure the layout and behavior of different types of views.
        -- Available layouts:
        --  'diff1_plain'
        --    |'diff2_horizontal'
        --    |'diff2_vertical'
        --    |'diff3_horizontal'
        --    |'diff3_vertical'
        --    |'diff3_mixed'
        --    |'diff4_mixed'
        -- For more info, see |diffview-config-view.x.layout|.
        default = {
            -- Config for changed files, and staged files in diff views.
            layout = "diff2_horizontal",
        },
        merge_tool = {
            -- Config for conflicted files in diff views during a merge or rebase.
            layout = "diff3_horizontal",
            disable_diagnostics = true, -- Temporarily disable diagnostics for conflict buffers while in the view.
        },
        file_history = {
            -- Config for changed files in file history views.
            layout = "diff2_horizontal",
        },
    },
    signs = {
        fold_closed = "",
        fold_open = "",
    },
    file_panel = {
        win_config = {
            position = "right", -- One of 'left', 'right', 'top', 'bottom'
            width = 30,         -- Only applies when position is 'left' or 'right'
            height = 100,       -- Only applies when position is 'top' or 'bottom'
        },
        listing_style = "tree", -- One of 'list' or 'tree'
        tree_options = {
            -- Only applies when listing_style is 'tree'
            flatten_dirs = true,             -- Flatten dirs that only contain one single dir
            folder_statuses = "only_folded", -- One of 'never', 'only_folded' or 'always'.
        },
    },
    file_history_panel = {
        win_config = {
            position = "right",
            width = 30,
            height = 100,
        },
        git = {
            log_options = {
                single_file = {
                    max_count = 256,   -- Limit the number of commits
                    follow = false,    -- Follow renames (only for single file)
                    all = false,       -- Include all refs under 'refs/' including HEAD
                    merges = false,    -- List only merge commits
                    no_merges = false, -- List no merge commits
                    reverse = false,   -- List commits in reverse order
                },
                multi_file = {
                    max_count = 256,   -- Limit the number of commits
                    all = false,       -- Include all refs under 'refs/' including HEAD
                    merges = false,    -- List only merge commits
                    no_merges = false, -- List no merge commits
                    reverse = false,   -- List commits in reverse order
                }
            },
        },
    },
    default_args = {
        -- Default args prepended to the arg-list for the listed commands
        DiffviewOpen = {},
        DiffviewFileHistory = {},
    },
    hooks = {
        -- See ':h diffview-config-hooks'
        view_opened = function(view)
            if signcolumn then -- 启动diffview时关闭gitsigns显示
                gitsigns_actions.toggle_signs(false)
                -- vim.cmd("Gitsigns toggle_signs")
            end
        end,
        view_closed = function(view)
            gitsigns_actions.toggle_signs(signcolumn) -- 还原gitsigns显示状态
        end
    },
    key_bindings = {
        disable_defaults = true, -- Disable the default key bindings
        -- The `view` bindings are active in the diff buffers, only when the current
        -- tabpage is a Diffview.
        view = {
            ["<tab>"]           = diffview_callback("select_next_entry"),  -- Open the diff for the next file
            ["<s-tab>"]         = diffview_callback("select_prev_entry"),  -- Open the diff for the previous file
            ["gf"]              = diffview_callback("goto_file"),          -- Open the file in a new split in previous tabpage
            ["<C-w><C-f>"]      = diffview_callback("goto_file_split"),    -- Open the file in a new split
            ["<C-w>gf"]         = diffview_callback("goto_file_tab"),      -- Open the file in a new tabpage
            ["<leader>e"]       = diffview_callback("focus_files"),        -- Bring focus to the files panel
            ["<leader>b"]       = diffview_callback("toggle_files"),       -- Toggle the files panel.
            ["<cr>"]            = "<Cmd>Gitsigns stage_hunk<CR>",          -- 选中行添加到stage
            -- ["<backspace>"]     = "<Cmd>Gitsigns undo_stage_hunk<CR>", -- 选中行从stage移除
            ["<leader><space>"] = diffview_callback("toggle_stage_entry"), -- 选中文件从stage中移除
        },
        file_panel = {
            ["k"]                   = diffview_callback("next_entry"),   -- Bring the cursor to the next file entry
            ["<down>"]              = diffview_callback("next_entry"),
            ["i"]                   = diffview_callback("prev_entry"),   -- Bring the cursor to the previous file entry.
            ["<up>"]                = diffview_callback("prev_entry"),
            ["<cr>"]                = diffview_callback("select_entry"), -- Open the diff for the selected entry.
            ["o"]                   = diffview_callback("select_entry"),
            ["<2-LeftMouse>"]       = diffview_callback("select_entry"),
            ["<leader><space>"]     = diffview_callback("toggle_stage_entry"), -- Stage / unstage the selected entry.
            ["S"]                   = diffview_callback("stage_all"),          -- Stage all entries.
            ["U"]                   = diffview_callback("unstage_all"),        -- Unstage all entries.
            ["X"]                   = diffview_callback("restore_entry"),      -- Restore entry to the state on the left side.
            ["<leader><backspace>"] = diffview_callback("restore_entry"),      -- 将条目恢复到左侧的状态(还原git记录的文件状态)
            ["R"]                   = diffview_callback("refresh_files"),      -- Update stats and entries in the file list.
            ["<tab>"]               = diffview_callback("select_next_entry"),
            ["<s-tab>"]             = diffview_callback("select_prev_entry"),
            ["gf"]                  = diffview_callback("goto_file"),
            ["<C-w><C-f>"]          = diffview_callback("goto_file_split"),
            ["<C-w>gf"]             = diffview_callback("goto_file_tab"),
            ["h"]                   = diffview_callback("listing_style"),       -- Toggle between 'list' and 'tree' views
            ["f"]                   = diffview_callback("toggle_flatten_dirs"), -- Flatten empty subdirectories in tree listing style.
            ["<leader>e"]           = diffview_callback("focus_files"),
            ["<leader>b"]           = diffview_callback("toggle_files"),
        },
        file_history_panel = {
            ["g!"]            = diffview_callback("options"),          -- Open the option panel
            ["<C-A-d>"]       = diffview_callback("open_in_diffview"), -- Open the entry under the cursor in a diffview
            ["y"]             = diffview_callback("copy_hash"),        -- Copy the commit hash of the entry under the cursor
            ["L"]             = diffview_callback("open_commit_log"),
            ["zR"]            = diffview_callback("open_all_folds"),
            ["zM"]            = diffview_callback("close_all_folds"),
            ["k"]             = diffview_callback("next_entry"),
            ["<down>"]        = diffview_callback("next_entry"),
            ["i"]             = diffview_callback("prev_entry"),
            ["<up>"]          = diffview_callback("prev_entry"),
            ["<cr>"]          = diffview_callback("select_entry"),
            ["o"]             = diffview_callback("select_entry"),
            ["<2-LeftMouse>"] = diffview_callback("select_entry"),
            ["<tab>"]         = diffview_callback("select_next_entry"),
            ["<s-tab>"]       = diffview_callback("select_prev_entry"),
            ["gf"]            = diffview_callback("goto_file"),
            ["<C-w><C-f>"]    = diffview_callback("goto_file_split"),
            ["<C-w>gf"]       = diffview_callback("goto_file_tab"),
            ["<leader>e"]     = diffview_callback("focus_files"),
            ["<leader>b"]     = diffview_callback("toggle_files"),
        },
        option_panel = {
            ["<tab>"] = diffview_callback("select"),
            ["q"]     = diffview_callback("close"),
        },
    },
}

-- ====================================================  颜色高亮  ====================================================
require('configs.diffview.colors')

-- ====================================================  键盘映射  ====================================================
require('configs.diffview.keymaps')
