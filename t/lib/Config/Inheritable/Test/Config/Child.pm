package Config::Inheritable::Test::Config::Child;
use strict;
use warnings;
use Config::Inheritable 'Config::Inheritable::Test::Config';

__PACKAGE__->load(
    title       => 'child title',
    desctiption => 'child description',
    author      => 'kentaro',
);

!!1;
