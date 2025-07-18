[
  {trigger: "mk", replacement: "$$0$$1", options: "tA"},
  {trigger: "md", replacement: "$$\n$0\n$$", options: "tw"},
  {trigger: "beg", replacement: "\\begin{$0}\n$1\n\\end{$0}", options: "mA"},
  {trigger: "\"", replacement: "\\text{$0}$1", options: "mA"},
  {trigger: "cal", replacement: "\\mathcal{$0}$1", options: "mA"},

  {trigger: "ooo", replacement: "\\infty", options: "mA"},
  {trigger: "\\sum", replacement: "\\sum_{${0:i}=${1:1}}^{${2:n}} $3", options: "m"},
  {trigger: "\\prod", replacement: "\\prod_{${0:i}=${1:1}}^{${2:n}} $3", options: "m"},
  {trigger: "lim", replacement: "\\lim_{ ${0:n} \\to ${1:\\infty} } $2", options: "mA"},
  {trigger: "...", replacement: "\\dots", options: "mA"},
  {trigger: "xx", replacement: "\\times", options: "mA"},
  {trigger: "**", replacement: "\\cdot", options: "mA"},
  {trigger: "_", replacement: "_{$0}$1", options: "mA"},
  {trigger: /([A-Za-z])(\d)/, replacement: "[[0]]_{[[1]]}", options: "rmA", description: "Auto letter subscript", priority: -1},

  {trigger: ">=", replacement: "\\geq", options: "mA"},
  {trigger: "<=", replacement: "\\leq", options: "mA"},
  {trigger: "=>", replacement: "\\implies", options: "mA"},
  {trigger: "=<", replacement: "\\impliedby", options: "mA"},
  {trigger: "//", replacement: "\\frac{$0}{$1}$2", options: "mA"},

  {trigger: "bcap", replacement: "\\bigcap", options: "mA"},
  {trigger: "bcup", replacement: "\\bigcup", options: "mA"},
  {trigger: "cap", replacement: "\\cap", options: "mA"},
  {trigger: "cup", replacement: "\\cup", options: "mA"},
  {trigger: "inn", replacement: "\\in", options: "mA"},
  {trigger: "notin", replacement: "\\not\\in", options: "mA"},
  {trigger: "\\\\\\", replacement: "\\setminus", options: "mA"},
  {trigger: "eset", replacement: "\\emptyset", options: "mA"},

  {trigger: "CC", replacement: "\\mathbb{C}", options: "mA"},
  {trigger: "RR", replacement: "\\mathbb{R}", options: "mA"},
  {trigger: "ZZ", replacement: "\\mathbb{Z}", options: "mA"},
  {trigger: "NN", replacement: "\\mathbb{N}", options: "mA"},

  // Trigonometry
  {trigger: /([^\\])(arcsin|sin|arccos|cos|arctan|tan|csc|sec|cot)/, replacement: "[[0]]\\[[1]]", options: "rmA", description: "Add backslash before trig funcs"},

  {trigger: /\\(arcsin|sin|arccos|cos|arctan|tan|csc|sec|cot)([A-Za-gi-z])/,
    replacement: "\\[[0]] [[1]]", options: "rmA",
    description: "Add space after trig funcs. Skips letter h to allow sinh, cosh, etc."},

  {trigger: /\\(sinh|cosh|tanh|coth)([A-Za-z])/,
    replacement: "\\[[0]] [[1]]", options: "rmA",
    description: "Add space after hyperbolic trig funcs"},

  // Environments
  {trigger: "pmat", replacement: "\\begin{pmatrix}\n$0\n\\end{pmatrix}", options: "MA"},
  {trigger: "bmat", replacement: "\\begin{bmatrix}\n$0\n\\end{bmatrix}", options: "MA"},
  {trigger: "Bmat", replacement: "\\begin{Bmatrix}\n$0\n\\end{Bmatrix}", options: "MA"},
  {trigger: "vmat", replacement: "\\begin{vmatrix}\n$0\n\\end{vmatrix}", options: "MA"},
  {trigger: "Vmat", replacement: "\\begin{Vmatrix}\n$0\n\\end{Vmatrix}", options: "MA"},
  {trigger: "matrix", replacement: "\\begin{matrix}\n$0\n\\end{matrix}", options: "MA"},

  {trigger: "pmat", replacement: "\\begin{pmatrix}$0\\end{pmatrix}", options: "nA"},
  {trigger: "bmat", replacement: "\\begin{bmatrix}$0\\end{bmatrix}", options: "nA"},
  {trigger: "Bmat", replacement: "\\begin{Bmatrix}$0\\end{Bmatrix}", options: "nA"},
  {trigger: "vmat", replacement: "\\begin{vmatrix}$0\\end{vmatrix}", options: "nA"},
  {trigger: "Vmat", replacement: "\\begin{Vmatrix}$0\\end{Vmatrix}", options: "nA"},
  {trigger: "matrix", replacement: "\\begin{matrix}$0\\end{matrix}", options: "nA"},

  {trigger: "cases", replacement: "\\begin{cases}\n$0\n\\end{cases}", options: "mA"},
  {trigger: "align", replacement: "\\begin{align}\n$0\n\\end{align}", options: "mA"},
  {trigger: "array", replacement: "\\begin{array}\n$0\n\\end{array}", options: "mA"},
]
