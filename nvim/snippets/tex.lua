local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node

local in_mathzone = function()
  local node = vim.treesitter.get_node()
  while node do
    if node:type() == "math_environment" or
        node:type() == "inline_formula" or
        node:type() == "displayed_equation" then
      return true
    end
    node = node:parent()
  end
  return false
end

local not_mathzone = function()
  return not in_mathzone()
end

-- Helper for simple text replacements in math mode
local math_snip = function(trig, replacement)
  return s(trig, t(replacement), { condition = in_mathzone, snippetType = "autosnippet" })
end

return {
  -- Regular snippets (need Tab to expand)

  -- Bold text
  s("bf", { t("\\textbf{"), i(1), t("}"), i(0) }, { condition = not_mathzone }),

  -- Italics
  s("it", { t("\\textit{"), i(1), t("}"), i(0) }, { condition = not_mathzone }),

  -- Various Operators
  s("\\sum", { t("\\sum_{"), i(1, "i"), t("="), i(2, "1"), t("}^{"), i(3, "n"), t("} "), i(0) },
    { condition = in_mathzone }),
  s("\\prod", { t("\\prod_{"), i(1, "i"), t("="), i(2, "1"), t("}^{"), i(3, "n"), t("} "), i(0) },
    { condition = in_mathzone }),
  s("tp", t("^{\\top}"), { condition = in_mathzone, wordTrig = false }),
  s("ev", { t("\\mathbb{E}\\left[ "), i(1), t(" \\right]"), i(0) }, { condition = in_mathzone }),
  s("evs", { t("\\mathbb{E}_{"), i(1), t("}\\left[ "), i(2), t(" \\right]"), i(0) },
    { condition = in_mathzone }),

  -- Environment
  s("ali", { t({ "\\begin{align*}", "\t" }), i(0), t({ "", "\\end{align*}" }) },
    { condition = not_mathzone }),
  s("def", { t({ "\\begin{definition}", "\t" }), i(0), t({ "", "\\end{definition}" }) },
    { condition = not_mathzone }),
  s("thm", { t({ "\\begin{theorem}", "\t" }), i(0), t({ "", "\\end{theorem}" }) },
    { condition = not_mathzone }),

  -- Lists
  s("enum", { t({ "\\begin{enumerate}", "  \\item " }), i(0), t({ "", "\\end{enumerate}" }) }),
  s("alphenum", { t({ "\\begin{enumerate}[label=\\alph*)]", "  \\item " }), i(0), t({ "", "\\end{enumerate}" }) }),
  s("itemize", { t({ "\\begin{itemize}", "  \\item " }), i(0), t({ "", "\\end{itemize}" }) }),

}, {
  -- Autosnippets (expand automatically)

  -- Enter/exit math mode
  s("mk", { t("$"), i(1), t("$"), i(0) }, { condition = not_mathzone, snippetType = "autosnippet" }),

  -- Text and cal
  s(";;", { t("\\text{"), i(1), t("}") }, { condition = in_mathzone, snippetType = "autosnippet" }),
  s("cal", { t("\\mathcal{"), i(1), t("}"), i(0) }, { condition = in_mathzone, snippetType = "autosnippet" }),

  -- Symbols
  math_snip("ooo", "\\infty"),
  math_snip("...", "\\dots"),
  math_snip("xx", "\\times"),
  math_snip("**", "\\cdot"),
  math_snip("invs", "^{-1}"),
  math_snip("@@", "^{2}"),

  -- Sub/superscripts
  s("_", { t("_{"), i(1), t("}"), i(0) }, { condition = in_mathzone, snippetType = "autosnippet" }),
  s("^", { t("^{"), i(1), t("}"), i(0) }, { condition = in_mathzone, snippetType = "autosnippet" }),

  -- Limits
  s("limm", { t("\\lim_{ "), i(1, "n"), t(" \\to "), i(2, "\\infty"), t(" } "), i(0) },
    { condition = in_mathzone, snippetType = "autosnippet" }),
  s("limsup", { t("\\limsup_{ "), i(1, "m"), t(" \\to "), i(2, "\\infty"), t(" } "), i(0) },
    { condition = in_mathzone, snippetType = "autosnippet" }),
  s("liminf", { t("\\liminf_{ "), i(1, "m"), t(" \\to "), i(2, "\\infty"), t(" } "), i(0) },
    { condition = in_mathzone, snippetType = "autosnippet" }),
  s("argmin", { t("\\mathop{\\mathrm{argmin}}_{"), i(1), t("} "), i(0) },
    { condition = in_mathzone, snippetType = "autosnippet" }),
  s("argmax", { t("\\mathop{\\mathrm{argmax}}_{"), i(1), t("} "), i(0) },
    { condition = in_mathzone, snippetType = "autosnippet" }),

  -- Brackets
  s("lr(", { t("\\left( "), i(1), t(" \\right) "), i(0) }, { condition = in_mathzone, snippetType = "autosnippet" }),
  s("lr{", { t("\\left\\{ "), i(1), t(" \\right\\} "), i(0) }, { condition = in_mathzone, snippetType = "autosnippet" }),
  s("lr[", { t("\\left[ "), i(1), t(" \\right] "), i(0) }, { condition = in_mathzone, snippetType = "autosnippet" }),
  s("lr|", { t("\\left| "), i(1), t(" \\right| "), i(0) }, { condition = in_mathzone, snippetType = "autosnippet" }),
  s("lra", { t("\\left< "), i(1), t(" \\right> "), i(0) }, { condition = in_mathzone, snippetType = "autosnippet" }),
  s("lrv", { t("\\left\\lVert "), i(1), t(" \\right\\rVert "), i(0) },
    { condition = in_mathzone, snippetType = "autosnippet" }),
  s("lrfloor", { t("\\lfloor "), i(1), t(" \\rfloor "), i(0) }, { condition = in_mathzone, snippetType = "autosnippet" }),
  s("lrceil", { t("\\lceil "), i(1), t(" \\rceil "), i(0) }, { condition = in_mathzone, snippetType = "autosnippet" }),

  -- Relations
  math_snip(">=", "\\geq"),
  math_snip("<=", "\\leq"),
  math_snip("=>", "\\implies"),
  math_snip("=<", "\\impliedby"),

  -- Fractions
  s("//", { t("\\frac{"), i(1), t("}{"), i(2), t("}"), i(0) }, { condition = in_mathzone, snippetType = "autosnippet" }),

  -- Sets
  math_snip("bcap", "\\bigcap"),
  math_snip("bcup", "\\bigcup"),
  math_snip("cap", "\\cap"),
  math_snip("cup", "\\cup"),
  math_snip("inn", "\\in"),
  math_snip("notin", "\\not\\in"),
  math_snip("\\\\\\", "\\setminus"),
  math_snip("eset", "\\emptyset"),

  -- Number sets
  math_snip("CC", "\\mathbb{C}"),
  math_snip("RR", "\\mathbb{R}"),
  math_snip("QQ", "\\mathbb{Q}"),
  math_snip("ZZ", "\\mathbb{Z}"),
  math_snip("NN", "\\mathbb{N}"),

  -- Matrices (in math mode)
  s("pmat", { t({ "\\begin{pmatrix}", "" }), i(0), t({ "", "\\end{pmatrix}" }) },
    { condition = in_mathzone, snippetType = "autosnippet" }),
  s("bmat", { t({ "\\begin{bmatrix}", "" }), i(0), t({ "", "\\end{bmatrix}" }) },
    { condition = in_mathzone, snippetType = "autosnippet" }),
  s("Bmat", { t({ "\\begin{Bmatrix}", "" }), i(0), t({ "", "\\end{Bmatrix}" }) },
    { condition = in_mathzone, snippetType = "autosnippet" }),
  s("vmat", { t({ "\\begin{vmatrix}", "" }), i(0), t({ "", "\\end{vmatrix}" }) },
    { condition = in_mathzone, snippetType = "autosnippet" }),
  s("Vmat", { t({ "\\begin{Vmatrix}", "" }), i(0), t({ "", "\\end{Vmatrix}" }) },
    { condition = in_mathzone, snippetType = "autosnippet" }),
  s("matrix", { t({ "\\begin{matrix}", "" }), i(0), t({ "", "\\end{matrix}" }) },
    { condition = in_mathzone, snippetType = "autosnippet" }),
  s("cases", { t({ "\\begin{cases}", "" }), i(0), t({ "", "\\end{cases}" }) },
    { condition = in_mathzone, snippetType = "autosnippet" }),
  s("array", { t({ "\\begin{array}", "" }), i(0), t({ "", "\\end{array}" }) },
    { condition = in_mathzone, snippetType = "autosnippet" }),
}
