use strict;
use warnings;
use Test::More;
use UNIVERSAL::require;

use lib 't/lib';

BEGIN { $ENV{CONFIG_ENV} = '' }

use Config::Inheritable::Env;
use Config::Inheritable::Test::Config::Child;

{
    my $env = {
        dsn    => 'dbi:mysql:dbname=config_default',
        logger => 'Screen',
    };

    is_deeply(Config::Inheritable::Test::Config::Child->config, +{
        title       => 'child title',
        description => 'child description',
        author      => 'kentaro',
        env         => Config::Inheritable::Env->new($env),
    });

    is_deeply(Config::Inheritable::Test::Config::Child->param('env')->to_hash, $env);
}

done_testing;
