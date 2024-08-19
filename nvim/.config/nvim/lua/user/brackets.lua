local autopairs = require("nvim-autopairs")
autopairs.setup {}

autopairs.remove_rule("'")
autopairs.remove_rule("\"")

local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local cmp = require('cmp')
cmp.event:on(
    'confirm_done',
    cmp_autopairs.on_confirm_done()
)

require("sentiment").setup {}
