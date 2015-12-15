=head1 NAME

EPrints::Plugin::Export::XML

=cut

package EPrints::Plugin::Export::XML;

use EPrints::Plugin::Export::XMLFile;

@ISA = ( "EPrints::Plugin::Export::XMLFile" );

use strict;

<<<<<<< HEAD
=======
my @PREFIXES = (
	{
		Prefix => '',
		NamespaceURI => EPrints::Const::EP_NS_DATA,
	},
	{
		Prefix => 'xsi',
		NamespaceURI => 'http://www.w3.org/2001/XMLSchema-instance',
	},
);

>>>>>>> 2b6259f2290a0e66c6dd1d800751684d72f6aaf6
sub new
{
	my( $class, %opts ) = @_;

	my( $self ) = $class->SUPER::new( %opts );

	$self->{name} = "EP3 XML";
	$self->{accept} = [ 'list/*', 'dataobj/*' ];
	$self->{visible} = "all";
	$self->{xmlns} = EPrints::Const::EP_NS_DATA;
	$self->{qs} = 0.8;
	$self->{mimetype} = 'application/vnd.eprints.data+xml; charset=utf-8';
	$self->{arguments}->{hide_volatile} = 1;

	return $self;
}

<<<<<<< HEAD
=======
sub root_attributes
{
	my ($self) = @_;

	my $schema_location = $self->{session}->current_url( host => 1, path => 'cgi', 'schema/ep2.xsd' );

	return (
		'{http://www.w3.org/2001/XMLSchema-instance}schemaLocation' => {
			Prefix => 'xsi',
			LocalName => 'schemaLocation',
			Name => 'xsi:schemaLocation',
			NamespaceURI => 'http://www.w3.org/2001/XMLSchema-instance',
			Value => EPrints::Const::EP_NS_DATA() . ' ' . $schema_location,
		},
	);
}

>>>>>>> 2b6259f2290a0e66c6dd1d800751684d72f6aaf6
sub output_list
{
	my( $self, %opts ) = @_;

	my $type = $opts{list}->get_dataset->confid;
	my $toplevel = $type."s";
	
	my $output = "";

	my $wr = EPrints::XML::SAX::PrettyPrint->new(
		Handler => EPrints::XML::SAX::Writer->new(
			Output => defined $opts{fh} ? $opts{fh} : \$output
	));

	$wr->start_document({});
	if( !$opts{omit_declaration} )
	{
		$wr->xml_decl({
			Version => '1.0',
			Encoding => 'utf-8',
		});
	}
<<<<<<< HEAD
	$wr->start_prefix_mapping({
		Prefix => '',
		NamespaceURI => EPrints::Const::EP_NS_DATA,
	});
=======
	$wr->start_prefix_mapping($_) for @PREFIXES;
>>>>>>> 2b6259f2290a0e66c6dd1d800751684d72f6aaf6

	if( !$opts{omit_root} )
	{
		$wr->start_element({
			Prefix => '',
			LocalName => $toplevel,
			Name => $toplevel,
			NamespaceURI => EPrints::Const::EP_NS_DATA,
<<<<<<< HEAD
			Attributes => {},
=======
			Attributes => {$self->root_attributes},
>>>>>>> 2b6259f2290a0e66c6dd1d800751684d72f6aaf6
		});
	}
	$opts{list}->map( sub {
		my( undef, undef, $item ) = @_;

		$self->output_dataobj( $item, %opts, Handler => $wr );
	});

	if( !$opts{omit_root} )
	{
		$wr->end_element({
			Prefix => '',
			LocalName => $toplevel,
			Name => $toplevel,
			NamespaceURI => EPrints::Const::EP_NS_DATA,
		});
	}
<<<<<<< HEAD
	$wr->end_prefix_mapping({
		Prefix => '',
		NamespaceURI => EPrints::Const::EP_NS_DATA,
	});
=======
	$wr->end_prefix_mapping($_) for @PREFIXES;
>>>>>>> 2b6259f2290a0e66c6dd1d800751684d72f6aaf6
	$wr->end_document({});

	return $output;
}

sub output_dataobj
{
	my( $self, $dataobj, %opts ) = @_;

	if( $opts{Handler} )
	{
		return $dataobj->to_sax( %opts );
	}

	my $output = "";

	my $type = $dataobj->get_dataset->base_id;
	my $toplevel = $type."s";
	
	my $wr = EPrints::XML::SAX::PrettyPrint->new(
		Handler => EPrints::XML::SAX::Writer->new(
			Output => defined $opts{fh} ? $opts{fh} : \$output
	));


	$wr->start_document({});
	if( !$opts{omit_declaration} )
	{
		$wr->xml_decl({
			Version => '1.0',
			Encoding => 'utf-8',
		});
	}
<<<<<<< HEAD
	$wr->start_prefix_mapping({
		Prefix => '',
		NamespaceURI => EPrints::Const::EP_NS_DATA,
	});
=======
	$wr->start_prefix_mapping($_) for @PREFIXES;
>>>>>>> 2b6259f2290a0e66c6dd1d800751684d72f6aaf6
	if( !$opts{omit_root} )
	{
		$wr->start_element({
			Prefix => '',
			LocalName => $toplevel,
			Name => $toplevel,
			NamespaceURI => EPrints::Const::EP_NS_DATA,
<<<<<<< HEAD
			Attributes => {},
=======
			Attributes => {$self->root_attributes},
>>>>>>> 2b6259f2290a0e66c6dd1d800751684d72f6aaf6
		});
	}
	$dataobj->to_sax( %opts, Handler => $wr );
	if( !$opts{omit_root} )
	{
		$wr->end_element({
			Prefix => '',
			LocalName => $toplevel,
			Name => $toplevel,
			NamespaceURI => EPrints::Const::EP_NS_DATA,
		});
	}
<<<<<<< HEAD
	$wr->end_prefix_mapping({
		Prefix => '',
		NamespaceURI => EPrints::Const::EP_NS_DATA,
	});
=======
	$wr->end_prefix_mapping($_) for @PREFIXES;
>>>>>>> 2b6259f2290a0e66c6dd1d800751684d72f6aaf6
	$wr->end_document({});

	return $output;
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

