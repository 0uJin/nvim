local status, _ = pcall(require, 'nvim-web-devicons')
if not status then
    return
end

local devicons = require('nvim-web-devicons')

devicons.setup {
    -- your personnal icons can go here (to override)
    -- you can specify color or cterm_color instead of specifying both of them
    -- DevIcon will be appended to `name`
    override = {
        -- zsh = {
        --     icon = "",
        --     color = "#1efac0",
        --     cterm_color = "65",
        --     name = "Zsh"
        -- }
    },
    -- globally enable default icons (default to false)
    -- will get overriden by `get_icons` option
    default = true,
}

devicons.get_icons()
devicons.set_icon {
    -- rs = {
    --     icon = "",
    --     color = "#dea584",
    --     cterm_color = "180",
    --     name = "Rs",
    -- },
    rs = {
        -- icon = "",
        -- icon = "",
        -- color = "#0efa50",
        icon = "",
        color = "#dea584",
        cterm_color = "180",
        name = "Rs",
    },
    zsh = {
        icon = "",
        color = "#1efac0",
        cterm_color = "65",
        name = "Zsh"
    },
}
