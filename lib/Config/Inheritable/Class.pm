package Config::Inheritable::Class;
use strict;
use warnings;

sub new {
    my ($class, $args) = @_;
    $args ||= {};
    bless $args, $class;
}

sub param {
    my $class = shift;

    if (@_ == 1) {
        my $key = shift;
        return $class->can('config') ? $class->config->{$key} : $class->{$key};
    }
    elsif (@_ && @_ % 2 == 0) {
        my %args = @_;
        while (my ($key, $value) = each %args) {
            $class->can('config') ? $class->config->{$key} = $value : $class->{$key} = $value;
        }
        $class->can('config') ? $class->config : $class;
    }
    else {
        return keys %{$class->can('config') ? %{$class->config} : %$class};
    }
}

sub to_hash {
    my $self = shift;
    +{ %{$self->can('cofig') ? $self->can('cofig') : $self } };
}

!!1;
