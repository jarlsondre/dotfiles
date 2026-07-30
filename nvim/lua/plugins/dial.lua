return {
  "monaqa/dial.nvim",
  config = function()
    local augend = require("dial.augend")

    require("dial.config").augends:register_group {
      -- default augends used when no group name is specified
      default = {
        augend.integer.alias.decimal,  -- nonnegative decimal number (0, 1, 2, 3, ...)
        augend.integer.alias.hex,      -- nonnegative hex number  (0x01, 0x1a1f, etc.)
        augend.date.alias["%Y/%m/%d"], -- date (2022/02/19, etc.)
        augend.constant.alias.bool,    -- boolean value (true <-> false)

        -- Python boolean values (True <-> False)
        augend.constant.new{
          elements = {"True", "False"},
          word = true,
          cyclic = true,
        },
        -- (and <-> or)
        augend.constant.new{
          elements = {"and", "or"},
          word = true, -- if false, "sand" is incremented into "sor", "doctor" into "doctand", etc.
          cyclic = true,  -- "or" is incremented into "and".
        },
      },
    }

    vim.keymap.set("n", "<C-a>", function()
      require("dial.map").manipulate("increment", "normal")
    end, { desc = "Dial: increment value under cursor" })
    vim.keymap.set("n", "<C-x>", function()
      require("dial.map").manipulate("decrement", "normal")
    end, { desc = "Dial: decrement value under cursor" })
    vim.keymap.set("n", "g<C-a>", function()
      require("dial.map").manipulate("increment", "gnormal")
    end, { desc = "Dial: increment additively on dot-repeat" })
    vim.keymap.set("n", "g<C-x>", function()
      require("dial.map").manipulate("decrement", "gnormal")
    end, { desc = "Dial: decrement additively on dot-repeat" })
    vim.keymap.set("v", "<C-a>", function()
      require("dial.map").manipulate("increment", "visual")
    end, { desc = "Dial: increment selected values" })
    vim.keymap.set("v", "<C-x>", function()
      require("dial.map").manipulate("decrement", "visual")
    end, { desc = "Dial: decrement selected values" })
    vim.keymap.set("v", "g<C-a>", function()
      require("dial.map").manipulate("increment", "gvisual")
    end, { desc = "Dial: increment selection, addend growing per line" })
    vim.keymap.set("v", "g<C-x>", function()
      require("dial.map").manipulate("decrement", "gvisual")
    end, { desc = "Dial: decrement selection, addend growing per line" })
  end,
}
