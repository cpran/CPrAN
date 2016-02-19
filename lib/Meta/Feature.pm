use 5.006;
use strict;
use warnings;
package CPrAN::Meta::Feature;

our $VERSION = '2.150006';

use CPrAN::Meta::Prereqs;

=head1 DESCRIPTION

A CPrAN::Meta::Feature object describes an optional feature offered by a CPrAN
distribution and specified in the distribution's F<META.json> (or F<META.yml>)
file.

For the most part, this class will only be used when operating on the result of
the C<feature> or C<features> methods on a L<CPrAN::Meta> object.

=method new

  my $feature = CPrAN::Meta::Feature->new( $identifier => \%spec );

This returns a new Feature object.  The C<%spec> argument to the constructor
should be the same as the value of the C<optional_feature> entry in the
distmeta.  It must contain entries for C<description> and C<prereqs>.

=cut

sub new {
  my ($class, $identifier, $spec) = @_;

  my %guts = (
    identifier  => $identifier,
    description => $spec->{description},
    prereqs     => CPrAN::Meta::Prereqs->new($spec->{prereqs}),
  );

  bless \%guts => $class;
}

=method identifier

This method returns the feature's identifier.

=cut

sub identifier  { $_[0]{identifier}  }

=method description

This method returns the feature's long description.

=cut

sub description { $_[0]{description} }

=method prereqs

This method returns the feature's prerequisites as a L<CPrAN::Meta::Prereqs>
object.

=cut

sub prereqs     { $_[0]{prereqs} }

1;

# ABSTRACT: an optional feature provided by a CPrAN distribution

__END__

=head1 BUGS

Please report any bugs or feature using the CPrAN Request Tracker.
Bugs can be submitted through the web interface at
L<http://rt.cpan.org/Dist/Display.html?Queue=CPrAN-Meta>

When submitting a bug or request, please include a test-file or a patch to an
existing test-file that illustrates the bug or desired feature.

=cut

# vim: ts=2 sts=2 sw=2 et :
