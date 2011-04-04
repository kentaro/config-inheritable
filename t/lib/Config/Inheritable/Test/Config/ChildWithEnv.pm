package Config::Inheritable::Test::Config::ChildWithEnv;
use strict;
use warnings;
use Config::Inheritable base => [qw(Config::Inheritable::Test::Config)],
                        env  => 'PLACK_ENV';

__PACKAGE__->load(
    title       => 'child_with_env title',
    description => 'child_with_env description',
    author      => 'kentaro',
);

!!1;
