use strict;
use warnings;

use FindBin '$RealBin';
use Test::More;
use File::Basename;
use File::BOM;

use Feed::Find;

my $base = 'http://example.com/tests/client/autodiscovery/';

for (glob "$RealBin/data/autodiscover/*html") {
  my $html = load_file($_);

  my @feeds = Feed::Find->find_in_html(\$html, $base);

  my $feed = basename $_;
  $feed =~ s/\.x?html$/.xml/;

  is(@feeds, 1, "Found 1 feed in $_");
  is($feeds[0], "$base$feed", "Correct feed found in $_");
}

done_testing;

sub load_file {
  my ($fn) = @_;

  open my $fh, '<:via(File::BOM)', $fn or die "$fn: $!\n";

  my $contents = do { local $/; <$fh> };

  return $contents;
}
