local status, _ = pcall(require, 'leap')
if not status then
    return
end

local leap = require('leap')
leap.opts.highlight_unlabeled_phase_one_targets = true
leap.add_default_mappings()

-- ====================================================  键盘映射  ====================================================
require('configs.leap.keymaps')
