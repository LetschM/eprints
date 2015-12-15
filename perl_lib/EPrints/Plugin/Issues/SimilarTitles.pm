=head1 NAME

EPrints::Plugin::Issues::SimilarTitles

=cut

package EPrints::Plugin::Issues::SimilarTitles;

<<<<<<< HEAD
use EPrints::Plugin::Export;

@ISA = ( "EPrints::Plugin::Issues" );
=======
use EPrints::Plugin::Issues::ExactTitleDups;

@ISA = ( "EPrints::Plugin::Issues::ExactTitleDups" );
>>>>>>> 2b6259f2290a0e66c6dd1d800751684d72f6aaf6

use strict;

sub new
{
	my( $class, %params ) = @_;

	my $self = $class->SUPER::new( %params );

	$self->{name} = "Similar titles";
<<<<<<< HEAD
=======
	$self->{accept} = [qw( list/eprint )];
>>>>>>> 2b6259f2290a0e66c6dd1d800751684d72f6aaf6

	return $self;
}

<<<<<<< HEAD
sub process_at_end
{
	my( $plugin, $info ) = @_;

	my $session = $plugin->{session};
	foreach my $code ( keys %{$info->{codemap}} )
	{
		my @set = @{$info->{codemap}->{$code}};
		next unless scalar @set > 1;
		foreach my $id ( @set )
		{
			my $eprint = EPrints::DataObj::EPrint->new( $session, $id );
			my $desc = $session->make_doc_fragment;
			$desc->appendChild( $session->make_text( "Similar title to " ) );
			$desc->appendChild( $eprint->render_citation_link_staff );
			OTHER: foreach my $id2 ( @set )
			{
				next OTHER if $id == $id2;
				# next if either of these have no title
				next OTHER if !EPrints::Utils::is_set( $info->{id_to_title}->{$id} );
				next OTHER if !EPrints::Utils::is_set( $info->{id_to_title}->{$id2} );
				# Don't match exact title matches
				next OTHER if $info->{id_to_title}->{$id} eq $info->{id_to_title}->{$id2};
				push @{$info->{issues}->{$id2}}, {
					type => "similar_title",
					id => "similar_title_$id",
					description => $desc,
				};
			}
		}
	}
}

# info is the data block being used to store cumulative information for
# processing at the end.
sub process_item_in_list
{
	my( $plugin, $item, $info ) = @_;

	my $title = $item->get_value( "title" );
	return if !EPrints::Utils::is_set( $title );

	$info->{id_to_title}->{$item->get_id} = $title;
	push @{$info->{codemap}->{make_code( $title )}}, $item->get_id;
=======
sub process_dataobj
{
	my( $self, $eprint, %opts ) = @_;

	my $title = $eprint->value( "title" );
	return if !EPrints::Utils::is_set( $title );

	push @{$self->{titles}->{make_code( $title )}}, $eprint->id;
>>>>>>> 2b6259f2290a0e66c6dd1d800751684d72f6aaf6
}

sub make_code
{
	my( $string ) = @_;

<<<<<<< HEAD
	# Lowercase string
	$string = "\L$string";

	# remove one and two character words
	$string =~ s/\b\w{1,2}\b//g; 

	# turn one-or more non-alphanumerics into a single space.
	$string =~ s/\W+/ /g;

	# remove leading and ending spaces
	$string =~ s/^ //;
	$string =~ s/ $//;

	# remove double characters
	$string =~ s/([^ ])\1/$1/g;

	# remove vowels 
	$string =~ s/[aeiou]//g;
=======
	local $_;
	for($string) {

	# Lowercase string
	$_ = lc;

	# remove one and two character words
	s/\b\p{Alnum}{1,2}\b//g; 

	# turn one-or more non-alphanumerics into a single space.
	s/\P{Alnum}+/ /g;

	# remove leading and ending spaces
	s/^ //;
	s/ $//;

	# remove double characters
	s/([^ ])\1/$1/g;

	# remove English vowels 
	s/[aeiou]//g;

	} # end of $_-alias
>>>>>>> 2b6259f2290a0e66c6dd1d800751684d72f6aaf6

	return $string;
}



1;



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

