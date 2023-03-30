local status, _ = pcall(require, 'colorizer')
if not status then
    return
end

local colorizer = require('colorizer')

local default_options = {
    RGB      = true,         -- #RGB hex codes
    RRGGBB   = true,         -- #RRGGBB hex codes
    names    = true,         -- "Name" codes like Blue
    RRGGBBAA = false,        -- #RRGGBBAA hex codes
    rgb_fn   = false,        -- CSS rgb() and rgba() functions
    hsl_fn   = false,        -- CSS hsl() and hsla() functions
    css      = false,        -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
    css_fn   = false,        -- Enable all CSS *functions*: rgb_fn, hsl_fn
    -- Available modes: foreground, background
    mode     = 'foreground', -- Set the display mode.
}


colorizer.setup({
    "*",
    html = default_options,
    javascript = default_options,
    lua = default_options,
    markdown = default_options,
    text = default_options,
    rust = default_options,
    golang = default_options,
    go = default_options,
    vim = default_options,
    norg = default_options,
})
