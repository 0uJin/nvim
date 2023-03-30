-- ################################################## 按键映射 ##################################################
local nvim = vim

-- -------------------------------------------------- debug图标 -------------------------------------------------
nvim.fn.sign_define('DapBreakpoint', { text = '●', texthl = '', linehl = '', numhl = '' })
nvim.fn.sign_define('DapBreakpointCondition', { text = '◆', texthl = '', linehl = '', numhl = '' })
nvim.fn.sign_define('DapBreakpointRejected', { text = '●', texthl = 'LineNr', linehl = '', numhl = '' })
nvim.fn.sign_define('DapLogPoint', { text = '◆', texthl = 'SpellRare', linehl = '', numhl = '' })
nvim.fn.sign_define('DapStopped', { text = '●▶', texthl = '', linehl = 'debugPC', numhl = '' })
