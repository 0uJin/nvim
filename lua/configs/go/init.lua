local status, _ = pcall(require, 'go')
if not status then
    return
end

local go = require('go')

go.setup()
