package CPrAN::Command::list;
# ABSTRACT: list all available plugins

use CPrAN -command;

use strict;
use warnings;

use Carp;
use Try::Tiny;
binmode STDOUT, ':utf8';

=head1 NAME

=encoding utf8

B<list> - List all known CPrAN plugins

=head1 SYNOPSIS

cpran list [options]

=head1 DESCRIPTION

List plugins available through the CPrAN catalog.

=cut

sub description {
  return "List plugins available through the CPrAN catalog";
}

=pod

B<list> will show a list of all plugins available to CPrAN.

=cut

sub validate_args {
  my ($self, $opt, $args) = @_;
}

=head1 EXAMPLES

    # Show all available plugins
    cpran list

=cut

sub execute {
  my ($self, $opt, $args) = @_;

  if (grep { /\bpraat\b/i } @{$args}) {
    if (scalar @{$args} > 1) {
      die "Praat must be the only argument for processing\n";
    }
    else {
      return $self->_praat($opt);
    }
  }

  my $app = CPrAN->new();
  my %params = %{$opt};

  my $cmd = CPrAN::Command::search->new({});
  return $app->execute_command($cmd, \%params, '.*');
}

sub opt_spec {
  return (
    [ "installed|i"   => "search on installed plugins" ],
    [ "wrap!"         => "enable / disable line wrap for result table" ],
  );
}

=item _praat()

Process praat

=cut

sub _praat {
  use Path::Class;

  my ($self, $opt) = @_;

  try {
    my $praat = $self->{app}->praat;
    my @releases = $praat->releases($opt);

    print "$_->{semver}\n" foreach @releases;
  }
  catch {
    chomp;
    warn "$_\n";
    die "Could not list Praat releases\n";
  };
}

=head1 AUTHOR

José Joaquín Atria <jjatria@gmail.com>

=head1 LICENSE

Copyright 2015-2016 José Joaquín Atria

This program is free software; you may redistribute it and/or modify it under
the same terms as Perl itself.

=head1 SEE ALSO

L<CPrAN|cpran>,
L<CPrAN::Plugin|plugin>,
L<CPrAN::Command::deps|deps>,
L<CPrAN::Command::init|init>,
L<CPrAN::Command::install|install>,
L<CPrAN::Command::remove|remove>,
L<CPrAN::Command::search|search>,
L<CPrAN::Command::show|show>,
L<CPrAN::Command::test|test>,
L<CPrAN::Command::update|update>,
L<CPrAN::Command::upgrade|upgrade>

=cut

our $VERSION = '0.0305'; # VERSION

1;
