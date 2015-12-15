######################################################################
#
# EPrints::DataObj::Message
#
######################################################################
#
#
######################################################################


=head1 NAME

B<EPrints::DataObj::Message> - user system message

=head1 DESCRIPTION

This is an internal class that shouldn't be used outside L<EPrints::Database>.

=head1 METHODS

=over 4

=cut

package EPrints::DataObj::Message;

<<<<<<< HEAD
@ISA = ( 'EPrints::DataObj' );
=======
use EPrints::DataObj::SubObject;
@ISA = ( 'EPrints::DataObj::SubObject' );
>>>>>>> 2b6259f2290a0e66c6dd1d800751684d72f6aaf6

use EPrints;

use strict;

<<<<<<< HEAD
=item $thing = EPrints::DataObj::Access->get_system_field_info
=======
=item $thing = EPrints::DataObj::Message->get_system_field_info
>>>>>>> 2b6259f2290a0e66c6dd1d800751684d72f6aaf6

Core fields.

=cut

sub get_system_field_info
{
	my( $class ) = @_;

	return
	( 
		{ name=>"messageid", type=>"counter", required=>1, can_clone=>0,
			sql_counter=>"messageid" },

		{ name=>"datestamp", type=>"timestamp", required=>1, text_index=>0 },

		{ name=>"userid", type=>"itemref", datasetid=>"user", required=>1, text_index=>0 },

		{ name=>"type", type=>"set", required=>1, text_index=>0,
			options => [qw/ message warning error /] },

<<<<<<< HEAD
		{ name=>"message", type=>"longtext", required=>1, text_index=>0 },
=======
		{ name=>"message", type=>"xml", required=>1, text_index=>0 },
>>>>>>> 2b6259f2290a0e66c6dd1d800751684d72f6aaf6

	);
}

<<<<<<< HEAD
=======
sub DESTROY
{
	my( $self ) = @_;

	# make sure we dispose of the message
	$self->{session}->xml->dispose( $self->{data}->{message} )
		if defined $self->{data}->{message};
}

>>>>>>> 2b6259f2290a0e66c6dd1d800751684d72f6aaf6
######################################################################

=back

=head2 Class Methods

=cut

######################################################################

<<<<<<< HEAD
=======
sub create_from_data
{
	my( $class, $session, $data, $dataset ) = @_;

	my $parent = $data->{_parent};
	if( defined $parent )
	{
		$data->{userid} = $parent->id;
	}

	return $class->SUPER::create_from_data( $session, $data, $dataset );
}

>>>>>>> 2b6259f2290a0e66c6dd1d800751684d72f6aaf6
######################################################################
=pod

=item $dataset = EPrints::DataObj::Message->get_dataset_id

Returns the id of the L<EPrints::DataSet> object to which this record belongs.

=cut
######################################################################

sub get_dataset_id
{
	return "message";
}

######################################################################

=head2 Object Methods

=cut

######################################################################

1;

__END__

=back

=head1 SEE ALSO

L<EPrints::DataObj> and L<EPrints::DataSet>.

=cut


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

