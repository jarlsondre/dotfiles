return {
  "micangl/cmp-vimtex",
  cond = not require("util.env").in_ssh(), -- follows vimtex, which is local-only
}
