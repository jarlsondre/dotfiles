return {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  config = function()
    local npairs = require("nvim-autopairs")
    local cond = require("nvim-autopairs.conds")

    npairs.setup({})

    npairs.get_rule("("):with_pair(cond.not_before_text("lr"))
    npairs.get_rule("{"):with_pair(cond.not_before_text("lr"))
    npairs.get_rule("["):with_pair(cond.not_before_text("lr"))
  end,
}
