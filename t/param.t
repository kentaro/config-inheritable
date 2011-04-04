use strict;
use warnings;
use Test::More;
use UNIVERSAL::require;

use lib 't/lib';

BEGIN { $ENV{CONFIG_ENV} = '' }

use Config::Inheritable::Env;
use Config::Inheritable::Test::Config;

{
    my $config = Config::Inheritable::Test::Config->new;
    my $env = {
        dsn    => 'dbi:mysql:dbname=config_default',
        logger => 'Screen',
    };

    is $config->param('title'), 'title';
    is $config->param('description'), 'description';
    is_deeply $config->param('env')->to_hash, $env;
}

{
    my $env = {
        dsn    => 'dbi:mysql:dbname=config_default',
        logger => 'Screen',
    };

    is(Config::Inheritable::Test::Config->param('title'), 'title');
    is(Config::Inheritable::Test::Config->param('description'), 'description');
    is_deeply(Config::Inheritable::Test::Config->param('env')->to_hash, $env);
}

done_testing;
