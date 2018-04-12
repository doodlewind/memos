# https://github.com/standard/standard/blob/master/bin/update-authors.sh
git log --reverse --format='%aN (%aE)' | perl -we '
BEGIN {
  %seen = (), @authors = ();
}
while (<>) {
  next if $seen{$_};
  $seen{$_} = push @authors, "- ", $_;
}
END {
  print "# Authors\n\n";
  print "#### Ordered by first contribution.\n\n";
  print @authors, "\n";
}
'
