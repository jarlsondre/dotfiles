# Build to ~/.cache/latexmk/<abs path, / -> %> so synced folders never see
# latexmk's constant rewrites. nvim/lua/plugins/vimtex.lua computes the SAME
# path -- keep the two in sync.
# NB: assign via $dir; a quoted `$out_dir = "..."` literal is what VimTeX
# greps for and would shadow its computed value.
use Cwd qw(abs_path);
use File::Path qw(make_path);

my $key = abs_path('.');
$key =~ s{/}{%}g;
my $dir = "$ENV{HOME}/.cache/latexmk/$key";
make_path($dir) unless -d $dir;
$out_dir = $dir;
