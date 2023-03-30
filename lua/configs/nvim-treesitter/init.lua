-- 查看支持列表
-- :TSInstallInfo
-- 安装语言支持, <language_to_install>为支持列表中的数据
-- :TSInstall <language_to_install>

local status, _ = pcall(require, 'nvim-treesitter')
if not status then
    return
end

local treesitter = require('nvim-treesitter.configs')
treesitter.setup {
    -- One of 'all', 'maintained' (parsers with maintainers), or a list of languages
    -- ensure_installed = 'maintained',
    -- ensure_installed = { 'norg', 'norg_meta', 'norg_table', 'haskell', 'cpp', 'c', 'javascript', 'markdown'},
    ensure_installed = { 'go', 'python', 'rust', 'vim', 'markdown', 'markdown_inline', 'norg', 'lua' },


    -- Install languages synchronously (only applied to `ensure_installed`)
    sync_install = true,

    -- List of parsers to ignore installing
    highlight = {
        -- `false` will disable the whole extension
        enable = true,
        -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
        -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
        -- the name of the parser)
        -- list of language that will be disabled

        -- disable = { 'rust', 'go', 'python' },

        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        -- additional_vim_regex_highlighting = false,
        additional_vim_regex_highlighting = { 'markdown' },
    },
}
