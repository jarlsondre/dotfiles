return {
  "lervag/vimtex",
  lazy = false, -- we don't want to lazy load VimTeX
  cond = not require("util.env").in_ssh(), -- LaTeX + Skim is a local-only workflow
  -- tag = "v2.15", -- uncomment to pin to a specific release
  init = function()
    -- Mirror ~/.latexmkrc's computed $out_dir exactly; VimTeX cannot read the
    -- Perl there, so this value is what wins. Keep the two in sync.
    vim.g.vimtex_compiler_latexmk = {
      out_dir = function(info)
        local key = (info.root:gsub("/", "%%"))
        return vim.fn.expand("~/.cache/latexmk/") .. key
      end,
    }

    -- VimTeX configuration goes here, e.g.
    vim.g.vimtex_view_method = "skim";
    vim.g.vimtex_format_enabled = 1
    vim.g.vimtex_view_skim_sync = 1
    -- Point Skim at a copy refreshed only when a run completes, so it does
    -- not reload the pdf on every intermediate latexmk pass.
    vim.g.vimtex_view_use_temp_files = 1
    vim.g.vimtex_quickfix_open_on_warning = 0
    vim.g.vimtex_quickfix_ignore_filters = {
      "Command terminated with space",
      "LaTeX Font Warning: Font shape",
      "Package caption Warning: The option",
      [[Underfull \\hbox (badness [0-9]*) in]],
      "Package enumitem Warning: Negative labelwidth",
      [[Overfull \\hbox ([0-9]*.[0-9]*pt too wide) in]],
      [[Package caption Warning: Unused \\captionsetup]],
      "Package typearea Warning: Bad type area settings!",
      [[Package fancyhdr Warning: \\headheight is too small]],
      [[Underfull \\hbox (badness [0-9]*) in paragraph at lines]],
      "Package hyperref Warning: Token not allowed in a PDF string",
      [[Overfull \\hbox ([0-9]*.[0-9]*pt too wide) in paragraph at lines]],
    }
  end,
}
