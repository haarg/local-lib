package inc::CheckTar;
use strict;
use warnings;
use IPC::Open3;

my $data = do { local $/; <DATA> };
$data = unpack 'u', $data;

my $fn = substr("long-file-name-" . ("1234567890" x 26), 0, 255 - 4) . '.txt';
my @names =
  sort
  map { $_, $_.$fn }
  map {
    substr("long-directory-name-for-$_-" . ("1234567890" x 26), 0, 255) . '/'
  }
  qw(gnu oldgnu pax posix);

sub checktar {
  my $tar = shift;
  my $pid = open3(my $in, my $out, undef, $tar, '-tz');
  print $in $data;
  close $in;
  my @lines = sort <$out>;
  chomp @lines;
  waitpid $pid, 0;
  return 0
    if @lines != @names;
  for my $i (0 .. $#lines) {
    return 0
      if $lines[$i] ne $names[$i];
  }
  return 1;
}

print checktar('tar');
print "\n";

__DATA__
M'XL(`$0L$U,"`^W9S6[:0!2&X5GG*GP#P,QX?F`1J<LN6/06K&`("L'(."J]
M^PY04$)I"C1,B>=]I,B6Y076\7QSCM/M=7M?AM5\,IS.G\1UR,`9LSD&AT=I
MI!)*:^?#GS)>2*6\\R(;B@A>EDU19YFHJZIY[[[OCV4Y$ZTS"Z7OC*9U^=!4
M]8_.O'@N.^.J[DSF+QVE<V.=[P]D:\]Z(G$QZK]>X][:S7KW;GN4>I\'FRS8
MK'^EG=4A%[1Q2HK,QES_DZ=YM7CGOG#;>-R^^G?_?_ZK??U?YW]._I/_U\__
MS?./I[-R^^@)//+^K-NLFFCYOUO_I^9_N)1)\K\=^:_.Z/^=H?^_@?RO9J,4
MM@#Z_^O77ZQ7^)G]O_>>_C^1_'_;_^_RG_Z?_(^0__3_$?)?G=W_^Q`#]/]1
M\O];L?I:%J.R7G95GLM?2^+(*[$H5I>]#W_]_N_T+O]SI5RH?VYS+;)5M/J'
MGY)H_Z>=RQ9%\WC_X57_9!^"[K3,BF;Z7-ZK?""U-@.GU]<>7EVS?2OOTMC_
M/[+LYW__=TI&[?_#3_G7_#\,-^I_]/O?T?[?J8/\U\[DY'\,5BORGW\$-+]O
M?]XDL/TE+W;^G[C_R_7W/QDS_Q/=_P_G/Z7_//]5R^E%+\59\Y_+U_.?-Y+]
M_S;FOTNK_KG.CLQ__7[*\]\'EOV"^2_D`/-?F^I_\ORWS7]I#?E_&_-?(OG/
M_/=F^[-2*>:_A.>_*^7_J?N_=,Q_````````````````````````````````
,`-KM)S*P//0`>```
`
