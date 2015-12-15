=head1 NAME

EPrints::Plugin::Screen::Staff::HistorySearch

=cut


package EPrints::Plugin::Screen::Staff::HistorySearch;

<<<<<<< HEAD
@ISA = ( 'EPrints::Plugin::Screen::AbstractSearch' );
=======
use EPrints::Plugin::Screen::Search;
@ISA = ( 'EPrints::Plugin::Screen::Search' );
>>>>>>> 2b6259f2290a0e66c6dd1d800751684d72f6aaf6

use strict;

sub new
{
	my( $class, %params ) = @_;

	my $self = $class->SUPER::new(%params);
	
	$self->{appears} = [
		{
			place => "admin_actions_editorial",
			position => 700,
		},
	];

	return $self;
}

<<<<<<< HEAD
sub search_dataset
{
	my( $self ) = @_;

	return $self->{session}->get_repository->get_dataset( "history" );
}

sub search_filters
{
	my( $self ) = @_;

	return;
}

=======
>>>>>>> 2b6259f2290a0e66c6dd1d800751684d72f6aaf6
sub render_links
{
	my( $self ) = @_;

	my $f = $self->{session}->make_doc_fragment;
	if( $self->{processor}->{search_subscreen} eq "results" )
	{
		my $style = $self->{session}->make_element( "style", type=>"text/css" );
		$style->appendChild( $self->{session}->make_text( ".ep_tm_main { width: 90%; }" ) );
		$f->appendChild( $style );
	}

	$f->appendChild( $self->SUPER::render_links );
	return $f;
}

<<<<<<< HEAD
sub allow_export { return 1; }

sub allow_export_redir { return 1; }

=======
>>>>>>> 2b6259f2290a0e66c6dd1d800751684d72f6aaf6
sub can_be_viewed
{
	my( $self ) = @_;

	return $self->allow( "staff/history_search" );
}

<<<<<<< HEAD
sub from
{
	my( $self ) = @_;

	my $sconf = {
=======
sub properties_from
{
	my( $self ) = @_;

	$self->{processor}->{dataset} = $self->repository->dataset( "history" );
	$self->{processor}->{searchid} = "staff";

	$self->SUPER::properties_from;
}

sub default_search_config
{
	return {
>>>>>>> 2b6259f2290a0e66c6dd1d800751684d72f6aaf6
		search_fields => [
			{ meta_fields => [ "userid.username" ] },
			{ meta_fields => [ "action" ] },
			{ meta_fields => [ "timestamp" ] },
			{ meta_fields => [ "objectid" ] },
		],
		order_methods => {
			userid => "userid",
			timestamp => "timestamp",
			timestampdesc => "-timestamp",
			objectid => "objectid",
		},
		default_order => "timestampdesc",
	};
<<<<<<< HEAD

			
	$self->{processor}->{sconf} = $sconf;

	$self->SUPER::from;
}

sub _vis_level
{
	my( $self ) = @_;

	return "staff";
}

sub get_controls_before
{
	my( $self ) = @_;

	return $self->get_basic_controls_before;	
}

sub render_result_row
{
	my( $self, $session, $result, $searchexp, $n ) = @_;

	return $result->render_citation_link_staff(
			$self->{processor}->{sconf}->{citation},  #undef unless specified
			n => [$n,"INTEGER"] );
}




=======
}

# suppress dataset=
sub hidden_bits
{
	return shift->EPrints::Plugin::Screen::AbstractSearch::hidden_bits();
}

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

