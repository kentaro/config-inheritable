package Config::Inheritable::Test::Config;
use strict;
use warnings;
use Config::Inheritable;

__PACKAGE__->load(
    title       => 'title',
    description => 'description',
    author      => 'kentaro',
    env         => {
        default => {
            dsn    => 'dbi:mysql:dbname=config_default',
            logger => 'Screen',
        },
        production_base => {
            dsn => 'dbi:mysql:dbname=config',
        },
        production => {
            __parent__ => 'production_base',
            logger     => 'File',

        },
        staging => {
            __parent__ => 'production',
            logger     => 'Screen',
        },
        development => {
            dsn    => 'dbi:mysql:dbname=development',
            logger => 'Screen',
        },
    },
);

!!1;
