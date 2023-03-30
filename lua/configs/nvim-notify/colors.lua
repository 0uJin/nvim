-- ################################################## 高亮配色 ##################################################
local nvim = vim

-- ================================================== 设置配色 ==================================================
nvim.api.nvim_set_hl(0, 'NotifyERRORBorder', { fg = '#8a1f1f' })
nvim.api.nvim_set_hl(0, 'NotifyWARNBorder', { fg = '#79491d' })
nvim.api.nvim_set_hl(0, 'NotifyINFOBorder', { fg = '#4f6752' })
nvim.api.nvim_set_hl(0, 'NotifyDEBUGBorder', { fg = '#8b8b8b' })
nvim.api.nvim_set_hl(0, 'NotifyTRACEBorder', { fg = '#4f3552' })
nvim.api.nvim_set_hl(0, 'NotifyERRORIcon', { fg = '#f70067' })
nvim.api.nvim_set_hl(0, 'NotifyWARNIcon', { fg = '#f79000' })
nvim.api.nvim_set_hl(0, 'NotifyINFOIcon', { fg = '#a9ff68' })
nvim.api.nvim_set_hl(0, 'NotifyDEBUGIcon', { fg = '#8b8b8b' })
nvim.api.nvim_set_hl(0, 'NotifyTRACEIcon', { fg = '#d484ff' })
nvim.api.nvim_set_hl(0, 'NotifyERRORTitle', { fg = '#f70067' })
nvim.api.nvim_set_hl(0, 'NotifyWARNTitle', { fg = '#f79000' })
nvim.api.nvim_set_hl(0, 'NotifyINFOTitle', { fg = '#a9ff68' })
nvim.api.nvim_set_hl(0, 'NotifyDEBUGTitle', { fg = '#8b8b8b' })
nvim.api.nvim_set_hl(0, 'NotifyTRACETitle', { fg = '#d484ff' })
nvim.api.nvim_set_hl(0, 'NotifyERRORBody', { link = 'Normal' })
nvim.api.nvim_set_hl(0, 'NotifyWARNBody', { link = 'Normal' })
nvim.api.nvim_set_hl(0, 'NotifyINFOBody', { link = 'Normal' })
nvim.api.nvim_set_hl(0, 'NotifyDEBUGBody', { link = 'Normal' })
nvim.api.nvim_set_hl(0, 'NotifyTRACEBody', { link = 'Normal' })
