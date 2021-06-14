use strict;
use warnings;

use FindBin '$RealBin';
use Test::More;

use Feed::Find;

for (glob "$RealBin/data/autodiscover/*") {
  my $html = load_file($_);

  my @feeds = Feed::Find->find_in_html(\$html, 'http://example.com/');

  is(@feeds, 1, "Found 1 feed in $_");
}

done_testing;

sub load_file {
  my ($fn) = @_;

  open my $fh, '<', $fn or die "$fn: $!\n";

  my $contents = do { local $/; <$fh> };

  return $contents;
}
