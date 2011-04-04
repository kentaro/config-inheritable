package Config::Inheritable::Test::Config::Child;
use strict;
use warnings;
use Config::Inheritable;

__PACKAGE__->load(
    title       => 'child title',
    desctiption => 'child description',
    author      => 'kentaro',
);

!!1;
