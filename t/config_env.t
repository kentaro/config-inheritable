use strict;
use warnings;
use Test::More;
use UNIVERSAL::require;

use lib 't/lib';

BEGIN { $ENV{PLACK_ENV} = 'staging' }

use Config::Inheritable::Env;
use Config::Inheritable::Test::Config::ChildWithEnv;

{
    my $env = {
        dsn    => 'dbi:mysql:dbname=config',
        logger => 'Screen',
    };

    is_deeply(Config::Inheritable::Test::Config::ChildWithEnv->config, +{
        title       => 'child_with_env title',
        description => 'child_with_env description',
        author      => 'kentaro',
        env         => Config::Inheritable::Env->new($env),
    });

    is_deeply(Config::Inheritable::Test::Config->param('env')->to_hash, $env);
}

done_testing;
