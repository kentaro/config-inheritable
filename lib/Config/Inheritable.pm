package Config::Inheritable;
use 5.008001;
use strict;
use warnings;
use parent qw(
    Config::Inheritable::Class
    Class::Data::Inheritable
);

use Config::Inheritable::Env;

use UNIVERSAL::require;
use Hash::Merge qw(merge);

our $VERSION = '0.01';

__PACKAGE__->mk_classdata(config => {});
__PACKAGE__->mk_classdata(env => 'CONFIG_ENV');
__PACKAGE__->mk_classdata(parents => []);

sub import {
    my ($class, @args) = @_;
    my ($call_pkg) = caller();

    {
        no strict 'refs';
        unshift @{"$call_pkg\::ISA"}, __PACKAGE__;
    }

    for my $base (@args) {
        push @{$call_pkg->parents}, $base;
    }
}

sub load {
    my ($class, %args) = @_;
    my $config = ($class->filter_with_env(\%args));

    if (scalar @{$class->parents}) {
        for my $parent (@{$class->parents}) {
            next if $class eq $parent;
            $parent->require or die $@;
            $config = merge $config, $parent->config;
            warn Dump $config;
        }
    }

    $class->config($config);
}

sub filter_with_env {
    my ($class, $config) = @_;

    return $config if !defined $class->env;

    my $config_env;
    my $env_configs;

    for my $key (keys %{$config || {}}) {
        if ($key eq 'env') {
            $env_configs = delete $config->{$key};

            for my $env (keys %{$env_configs || {}}) {
                $config_env = $env_configs->{$env}
                    if $env eq $ENV{$class->env};
            }
        }
    }

    if (!$config_env && $env_configs->{default}) {
        $config_env = $env_configs->{default};
    }

    $config_env && ($config_env = Config::Inheritable::Env->new(
        $class->merge_parent($config_env, $env_configs)
    ));

    $config->{env} = $config_env if $config_env;
    $config;
}

sub merge_parent {
    my ($class, $config, $env_configs) = @_;

    return {} if !$config;
    return $config if !$env_configs;

    if (my $parent_env = delete $config->{__parent__}) {
        $config = merge $config, $class->merge_parent(
            $env_configs->{$parent_env},
            $env_configs,
        );
    }

    $config;
}

!!1;

__END__

=encoding utf8

=head1 NAME

Config::Inheritable -

=head1 SYNOPSIS

  use Config::Inheritable;

=head1 DESCRIPTION

Config::Inheritable is

=head1 AUTHOR

Kentaro Kuribayashi E<lt>kentarok@gmail.comE<gt>

=head1 SEE ALSO

=head1 LICENSE

Copyright (C) Kentaro Kuribayashi

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
