<<<<<<< HEAD
######################################################################
#
# EPrints::MetaField::Int;
#
######################################################################
#
#
######################################################################

=pod

=head1 NAME

B<EPrints::MetaField::Int> - no description

=head1 DESCRIPTION

not done
=======
=for Pod2Wiki

=head1 NAME

EPrints::MetaField::Int - integers

=head1 DESCRIPTION

=head1 PROPERTIES

=over 4

=item maxlength = 9

Maximum digits to allow (excluding '-' for negative numbers). The maximum allowed will depend on your database (probably 18 for BIGINT).

=back

=head1 METHODS
>>>>>>> 2b6259f2290a0e66c6dd1d800751684d72f6aaf6

=over 4

=cut

package EPrints::MetaField::Int;

<<<<<<< HEAD
use strict;
use warnings;

BEGIN
{
	our( @ISA );

	@ISA = qw( EPrints::MetaField );
}

use EPrints::MetaField;
=======
use EPrints::Database;

@ISA = qw( EPrints::MetaField );

use strict;

our %MAXLENGTHS = (
	2 => EPrints::Database::SQL_TINYINT,
	4 => EPrints::Database::SQL_SMALLINT,
#	6 => EPrints::Database::SQL_MEDIUMINT, # Not widely supported
	9 => EPrints::Database::SQL_INTEGER,
	18 => EPrints::Database::SQL_BIGINT,
);

use EPrints::MetaField;

sub new
{
	my( $class, %params ) = @_;

	$params{maxlength} = delete $params{digits}
		if exists $params{digits};

	my $self = $class->SUPER::new( %params );

	return $self;
}
>>>>>>> 2b6259f2290a0e66c6dd1d800751684d72f6aaf6

sub get_sql_type
{
	my( $self, $session ) = @_;

<<<<<<< HEAD
	return $session->get_database->get_column_type(
		$self->get_sql_name(),
		EPrints::Database::SQL_INTEGER,
=======
	my $db_type;
	foreach my $len (sort { $a <=> $b } keys %MAXLENGTHS)
	{
		next if !defined $MAXLENGTHS{$len};
		$db_type = $MAXLENGTHS{$len}, last if $len >= $self->property( "maxlength" );
	}
	if( !defined $db_type )
	{
		EPrints->abort( "No database type that is long enough to support ".$self->property( "maxlength" ). " digits");
	}

	return $session->get_database->get_column_type(
		$self->get_sql_name(),
		$db_type,
>>>>>>> 2b6259f2290a0e66c6dd1d800751684d72f6aaf6
		!$self->get_property( "allow_null" ),
		undef,
		undef,
		$self->get_sql_properties,
	);
}

sub get_max_input_size
{
	my( $self ) = @_;

<<<<<<< HEAD
	return $self->get_property( "digits" );
=======
	return $self->get_property( "maxlength" );
>>>>>>> 2b6259f2290a0e66c6dd1d800751684d72f6aaf6
}

sub ordervalue_basic
{
	my( $self , $value ) = @_;

	unless( EPrints::Utils::is_set( $value ) )
	{
		return "";
	}

	# just in case we still use eprints in year 200k 
<<<<<<< HEAD
	my $pad = $self->get_property( "digits" );
=======
	my $pad = $self->get_property( "maxlength" );
>>>>>>> 2b6259f2290a0e66c6dd1d800751684d72f6aaf6
	return sprintf( "%0".$pad."d",$value );
}

sub render_search_input
{
	my( $self, $session, $searchfield ) = @_;
	
<<<<<<< HEAD
=======
	my $maxlength = $self->property( "maxlength" ) + 1; # digits plus '-' for negative
>>>>>>> 2b6259f2290a0e66c6dd1d800751684d72f6aaf6
	return $session->render_input_field(
				class => "ep_form_text",
				name=>$searchfield->get_form_prefix,
				value=>$searchfield->get_value,
				size=>9,
<<<<<<< HEAD
				maxlength=>100 );
=======
				maxlength=>$maxlength );
>>>>>>> 2b6259f2290a0e66c6dd1d800751684d72f6aaf6
}

sub from_search_form
{
	my( $self, $session, $prefix ) = @_;

	my $value = $session->param( $prefix );
	return $value unless EPrints::Utils::is_set( $value );

	my $regexp = $self->property( "regexp" );
	my $range = qr/-|(?:\.\.)/;

	if( $value !~ /^(?:$regexp$range?)|(?:$regexp?$range$regexp)$/ )
	{
		return( undef,undef,undef, $session->html_phrase( "lib/searchfield:int_err" ) );
	}

	return( $value );
}

sub render_search_value
{
	my( $self, $session, $value ) = @_;

	my $type = $self->get_type;

	my $regexp = $self->property( "regexp" );
	my $range = qr/-|(?:\.\.)/;

	if( $value =~ m/^($regexp)$range($regexp)$/ )
	{
		return $session->html_phrase(
			"lib/searchfield:desc:".$type."_between",
			from => $session->make_text( $1 ),
			to => $session->make_text( $2 ) );
	}

	if( $value =~ m/^$range($regexp)$/ )
	{
		return $session->html_phrase(
			"lib/searchfield:desc:".$type."_orless",
			to => $session->make_text( $1 ) );
	}

	if( $value =~ m/^($regexp)$range$/ )
	{
		return $session->html_phrase(
			"lib/searchfield:desc:".$type."_ormore",
			from => $session->make_text( $1 ) );
	}

	return $session->make_text( $value );
}

sub get_search_conditions_not_ex
{
	my( $self, $session, $dataset, $search_value, $match, $merge,
		$search_mode ) = @_;
	
	# N
	# N..
	# ..N
	# N..N

	my $regexp = $self->property( "regexp" );
	my $range = qr/-|(?:\.\.)/;

	if( $search_value =~ m/^$regexp$/ )
	{
		return EPrints::Search::Condition->new( 
			'=', 
			$dataset,
			$self, 
			$search_value );
	}

	my( $lower, $higher ) = $search_value =~ m/^($regexp)?$range($regexp)?$/;

	my @r = ();
	if( defined $lower )
	{
		push @r, EPrints::Search::Condition->new( 
				'>=',
				$dataset,
				$self,
				$1);
	}
	if( defined $higher )
	{
		push @r, EPrints::Search::Condition->new( 
				'<=',
				$dataset,
				$self,
				$2 );
	}

	if( !@r )
	{
		return EPrints::Search::Condition->new( 'FALSE' );
	}
	elsif( @r == 1 )
	{
		return $r[0];
	}
	else
	{
		return EPrints::Search::Condition->new( "AND", @r );
	}
}

sub get_search_group { return 'number'; } 

sub get_property_defaults
{
	my( $self ) = @_;
	my %defaults = $self->SUPER::get_property_defaults;
<<<<<<< HEAD
	$defaults{digits} = $EPrints::MetaField::FROM_CONFIG;
=======
	$defaults{maxlength} = 9, # SQL_INT
>>>>>>> 2b6259f2290a0e66c6dd1d800751684d72f6aaf6
	$defaults{text_index} = 0;
	$defaults{regexp} = qr/-?[0-9]+/;
	return %defaults;
}

sub get_xml_schema_type
{
	return "xs:integer";
}

sub render_xml_schema_type
{
	my( $self, $session ) = @_;

	return $session->make_doc_fragment;
}

# integer fields must be NULL or a number, can't be ''
sub xml_to_epdata_basic
{
	my( $self, $session, $xml, %opts ) = @_;

	my $value = EPrints::Utils::tree_to_utf8( scalar $xml->childNodes );

	return EPrints::Utils::is_set( $value ) ? $value : undef;
}

sub sql_row_from_value
{
	my( $self, $session, $value ) = @_;

	return( $value );
}

sub form_value_basic
{
	my( $self, $session, $basename, $object ) = @_;

	my $value = $self->SUPER::form_value_basic( $session, $basename, $object );

	return defined $value && $value =~ $self->property( "regexp" ) ?
			$value :
			undef;
}

<<<<<<< HEAD
######################################################################
1;

=======
sub create_ordervalues_field
{
	my( $self, $session, $langid ) = @_;

	my $field = $self->clone;
	$field->set_property( sql_index => 0 );

	return $field;
}

sub ordervalue
{
	my( $self, @params ) = @_;

	my $value = $self->SUPER::ordervalue( @params );

	return EPrints::Utils::is_set( $value ) ? $value : 0;
}

# Integer columns can only be NULL, never ''
sub get_search_conditions
{
	my( $self, $session, $dataset, $search_value, $match, $merge,
		$search_mode ) = @_;

	if( $match eq "SET" )
	{
		return EPrints::Search::Condition->new(
				"is_not_null",
				$dataset,
				$self );
	}

	return shift->SUPER::get_search_conditions( @_ );
}

######################################################################
1;

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

