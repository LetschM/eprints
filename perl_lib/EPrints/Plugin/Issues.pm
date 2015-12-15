=head1 NAME

EPrints::Plugin::Issues

<<<<<<< HEAD
=======
=head1 SYNOPSIS

	my $plugin = $repo->plugin( "Issues::..." );

	$plugin->process_dataobj( $eprint );
	$plugin->finish;

	$list = $repo->dataset( "eprint" )->search;

	$plugin->process_list( list => $list );
	$plugin->finish;

=head1 METHODS

=over 4

>>>>>>> 2b6259f2290a0e66c6dd1d800751684d72f6aaf6
=cut

package EPrints::Plugin::Issues;

use strict;

our @ISA = qw/ EPrints::Plugin /;

$EPrints::Plugin::Issues::DISABLE = 1;

<<<<<<< HEAD
=======
sub new
{
	my( $self, %params ) = @_;

	$params{accept} = [] if !exists $params{accept};
	$params{Handler} = EPrints::CLIProcessor->new( session => $params{session} )
		if !exists $params{Handler};

	return $self->SUPER::new( %params );
}

sub handler
{
	my( $self ) = @_;

	return $self->{Handler};
}

sub set_handler
{
	my( $self, $handler ) = @_;

	return $self->{Handler} = $handler;
}

>>>>>>> 2b6259f2290a0e66c6dd1d800751684d72f6aaf6
sub matches 
{
	my( $self, $test, $param ) = @_;

<<<<<<< HEAD
	if( $test eq "is_available" )
	{
		return( $self->is_available() );
=======
	if( $test eq "can_accept" )
	{
		return( $self->can_accept( $param ) );
>>>>>>> 2b6259f2290a0e66c6dd1d800751684d72f6aaf6
	}

	# didn't understand this match 
	return $self->SUPER::matches( $test, $param );
}

<<<<<<< HEAD
sub is_available
{
	my( $self ) = @_;

	return 1;
}

# return all issues on this set, as a hash keyed on eprintid.
sub list_issues
{
	my( $plugin, %opts ) = @_;

	my $info = { issues => {}, opts=>\%opts };
	$opts{list}->map( 
		sub { 
			my( $session, $dataset, $item, $info ) = @_;
			my @issues = $plugin->process_item_in_list( $item, $info );
		},
		$info
	);
	$plugin->process_at_end( $info );

	return $info->{issues};
}

# This is used to add any additional issues based on cumulative information
sub process_at_end
{
	my( $plugin, $info ) = @_;

	# nothing by default
}

# info is the data block being used to store cumulative information for
# processing at the end.
sub process_item_in_list
{
	my( $plugin, $item, $info ) = @_;

	my @issues = $plugin->item_issues( $item );
	foreach my $issue ( @issues )
	{
		push @{$info->{issues}->{$item->get_id}}, $issue;
	}
}


# return an array of issues. Issues should be of the type
# { description=>XHTMLDOM, type=>string }
# if one item can have multiple occurances of the same issue type then add
# an id field too. This only need to be unique within the item.
sub item_issues
{
	my( $plugin, $dataobj ) = @_;
	
	return ();
=======
sub can_accept { shift->EPrints::Plugin::Export::can_accept( @_ ) }

=item $issue = $plugin->create_issue( $parent, $epdata [, %opts ] )

Utility method to create a new issue for $parent from $epdata.

=cut

sub create_issue
{
	my( $self, $parent, $epdata, %opts ) = @_;

	# set the parent, without side-effecting
	local $epdata->{datasetid} = $parent->{dataset}->base_id;
	local $epdata->{objectid} = $parent->id;

	return $self->handler->epdata_to_dataobj( $epdata,
			%opts,
			dataset => $self->repository->dataset( "issue" ),
		);
}

=item $plugin->process_list( list => $list [, %opts ] )

Process a L<EPrints::List> of items. Call L</finish> to perform any summary-data actions.

=cut

sub process_list
{
	my( $self, %opts ) = @_;

	$opts{list}->map(sub {
		(undef, undef, my $item) = @_;

		$self->process_dataobj( $item, %opts );
	});
}

=item $plugin->process_dataobj( $dataobj [, %opts ] )

Process a single L<EPrints::DataObj>. Call L</finish> to perform any summary-data actions.

=cut

sub process_dataobj
{
	my( $self, $item, %opts ) = @_;

	# nothing to do
}

=item $plugin->finish

Finish processing for issues and clean-up any state information stored in the plugin.

=cut

sub finish
{
	my( $self, %opts ) = @_;
>>>>>>> 2b6259f2290a0e66c6dd1d800751684d72f6aaf6
}

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

