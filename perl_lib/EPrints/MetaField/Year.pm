######################################################################
#
# EPrints::MetaField::Year;
#
######################################################################
#
#
######################################################################

=pod

=head1 NAME

<<<<<<< HEAD
B<EPrints::MetaField::Year> - no description
=======
EPrints::MetaField::Year - no description
>>>>>>> 2b6259f2290a0e66c6dd1d800751684d72f6aaf6

=head1 DESCRIPTION

not done

=over 4

=cut

package EPrints::MetaField::Year;

<<<<<<< HEAD
use strict;
use warnings;

BEGIN
{
	our( @ISA );

	@ISA = qw( EPrints::MetaField::Int );
}

use EPrints::MetaField::Int;

sub render_search_input
{
	my( $self, $session, $searchfield ) = @_;
	
	return $session->render_input_field(
				class => "ep_form_text",
				name=>$searchfield->get_form_prefix,
				value=>$searchfield->get_value,
				size=>9,
				maxlength=>9 );
}

sub from_search_form
{
	my( $self, $session, $prefix ) = @_;

	my $val = $session->param( $prefix );
	return unless defined $val;

	if( $val =~ m/^(\d\d\d\d)?\-?(\d\d\d\d)?/ )
	{
		return( $val );
	}
			
	return( undef,undef,undef, $session->html_phrase( "lib/searchfield:year_err" ) );
}
=======
use EPrints::MetaField::Int;
@ISA = qw( EPrints::MetaField::Int );

use strict;
>>>>>>> 2b6259f2290a0e66c6dd1d800751684d72f6aaf6

sub get_property_defaults
{
	my( $self ) = @_;
	my %defaults = $self->SUPER::get_property_defaults;
<<<<<<< HEAD
	$defaults{digits} = 4;
=======
	$defaults{maxlength} = 4; # Still running Perl in 10000?
	$defaults{regexp} = qr/\d{4}/;
>>>>>>> 2b6259f2290a0e66c6dd1d800751684d72f6aaf6
	return %defaults;
}

sub should_reverse_order { return 1; }

######################################################################
1;

<<<<<<< HEAD
=======
=back

>>>>>>> 2b6259f2290a0e66c6dd1d800751684d72f6aaf6
=head1 COPYRIGHT

=for COPYRIGHT BEGIN

Copyright 2000-2011 University of Southampton.

=for COPYRIGHT END

=for LICENSE BEGIN

This file is part of EPrints L<http://www.eprints.org/>.

EPrints is free software: you can redistribute it and/or modify it
under the terms of the GNU Lesser General Public License as published
by the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

EPrints is distributed in the hope that it will be useful, but WITHOUT
ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public
License for more details.

You should have received a copy of the GNU Lesser General Public
License along with EPrints.  If not, see L<http://www.gnu.org/licenses/>.

=for LICENSE END

