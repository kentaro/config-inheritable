package Config::Inheritable::Test::Config::Child;
use strict;
use warnings;
use Config::Inheritable base => [qw(Config::Inheritable::Test::Config)];

__PACKAGE__->load(
    title       => 'child title',
    description => 'child description',
    author      => 'kentaro',
);

!!1;
