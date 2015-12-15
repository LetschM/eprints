<<<<<<< HEAD
######################################################################
#
# EPrints::Page
#
######################################################################
#
#
######################################################################

=pod

=======
>>>>>>> 2b6259f2290a0e66c6dd1d800751684d72f6aaf6
=head1 NAME

B<EPrints::Page> - A Webpage 

=head1 DESCRIPTION

This class describes a webpage suitable for serving via mod_perl or writing to a file.

<<<<<<< HEAD
=over 4

=item $page = $repository->xhtml->page( { title => ..., body => ... }, %options );

Construct a new page.

=item $page->send( [%options] )

Send this page via the current HTTP connection. 

=cut

=item $page->write_to_file( $filename )

Write this page to the given filename.

=back
=======
Supported pins:

=over 4

=item title

=item title.textonly

=item page

=item head

=item template

=back

=head1 METHODS

=over 4
>>>>>>> 2b6259f2290a0e66c6dd1d800751684d72f6aaf6

=cut

package EPrints::Page;

<<<<<<< HEAD
sub new
{
	my( $class, $repository, $page, %options ) = @_;

	EPrints::Utils::process_parameters( \%options, {
		   add_doctype => 1,
	});

	return bless { repository=>$repository, page=>$page, %options }, $class;
}

sub send_header
{
	my( $self, %options ) = @_;

	$self->{repository}->send_http_header( %options );
}

sub send
{
	my( $self, %options ) = @_;

	if( !defined $self->{page} ) 
	{
		EPrints::abort( "Attempt to send the same page object twice!" );
	}

	binmode(STDOUT, ":utf8");

	$self->send_header( %options );

	eval {
		if( $self->{add_doctype} )
		{
			print $self->{repository}->xhtml->doc_type;
		}
		print delete($self->{page});
	};
	if( $@ )
	{
		if( $@ !~ m/Software caused connection abort/ )
		{
			EPrints::abort( "Error in send_page: $@" );	
		}
		else
		{
			die $@;
		}
	}
}

sub write_to_file
{
	my( $self, $filename, $wrote_files ) = @_;

	if( !defined $self->{page} ) 
	{
		EPrints::abort( "Attempt to write the same page object twice!" );
	}

	if( open(my $fh, ">:utf8", $filename) )
	{
		if( $self->{add_doctype} )
		{
			print $fh $self->{repository}->xhtml->doc_type;
		}
		print $fh delete($self->{page});
		if( defined $wrote_files )
		{
			$wrote_files->{$filename} = 1;
		}
	}
	else
	{
		EPrints::abort( <<END );
Can't open to write to file: $filename
END
	}
}

=======
use strict;

=item $page = EPrints::Page->new( %options )

=cut

sub new
{
	my( $class, %self ) = @_;

	$self{pins} = {} if !exists $self{pins};

	return bless \%self, $class;
}

=item $page = EPrints::Page->new_from_path( $path, %options )

Read pins from $path on disk.

=cut

sub new_from_path
{
	my( $class, $prefix, %params ) = @_;

	my $self = $class->new( %params );

	foreach my $pinid (qw( title title.textonly page head template ))
	{
		local $/;
		open(my $fh, "<:utf8", "$prefix.$pinid") or next;
		$self->{pins}{"utf-8.$pinid"} = <$fh>;
		close($fh);
		chomp($self->{pins}{"utf-8.$pinid"}); # remove trailing newline
	}

	return $self;
}

=item $page = EPrints::Page->new_from_file( $filename, %options )

Read pins from an .xpage $filename source XML file.

=cut

sub new_from_file
{
	my( $class, $filename, %params ) = @_;

	my $self = $class->new( %params );

	my $xml = $self->{repository}->xml;
	my $doc = $self->{repository}->parse_xml( $filename );

	return undef if !defined $doc;

    foreach my $node ( $doc->documentElement->childNodes )
	{
		my $part = $node->nodeName;
		$part =~ s/^.*://;
		next unless( $part eq "head" || $part eq "body" || $part eq "title" || $part eq "template" );

		my $frag = $xml->create_document_fragment;
		$self->{pins}->{$part} = $frag;

		for($node->childNodes)
		{
			$frag->appendChild( 
				EPrints::XML::EPC::process(
					$_,
					in => $filename,
					session => $self->{repository} ) );
		}
	}

	$xml->dispose( $doc );

	$self->{pins}->{page} = delete $self->{pins}->{body};

	return $self;
}

=item $pins = $page->pins()

Returns the plain-text pins in this page.

=cut

sub pins { shift->{pins} }

=item $utf8 = $page->utf8_pin( $pinid )

Returns the pin identified by $pinid as serialised xhtml.

=cut

sub utf8_pin
{
	my( $self, $pinid ) = @_;

	if( exists $self->{pins}{$pinid} )
	{
		return $self->{repository}->xhtml->to_xhtml( $self->{pins}{$pinid} );
	}
	elsif( exists $self->{pins}{"utf-8.$pinid"} )
	{
		return $self->{pins}{"utf-8.$pinid"};
	}
	else
	{
		return "";
	}
}

=item $text = $page->text_pin( $pinid )

Returns the pin identified by $pinid as plain text.

=cut

sub text_pin
{
	my( $self, $pinid ) = @_;

	if( exists $self->{pins}{"utf-8.$pinid.textonly"} )
	{
		return $self->{pins}{"utf-8.$pinid.textonly"};
	}
	elsif( exists $self->{pins}{$pinid} )
	{
		return $self->{repository}->xhtml->to_text_dump( $self->{pins}{$pinid},
				show_links => 0,
			);
	}
	elsif( exists $self->{pins}{"utf-8.$pinid"} )
	{
		return $self->{pins}{"utf-8.$pinid"};
	}
	else
	{
		return "";
	}
}

=item @files = $page->write_to_path( $path )

Write the pins to files prefixed by $path, where each pin will be written as "$path.{pinname}".

Returns the list of files written (full path).

=cut

sub write_to_path
{
	my( $self, $prefix ) = @_;

	my @r;

	my $dir = $prefix;
	$dir =~ s{[^/]+$}{};
	EPrints->system->mkdir( $dir );

	foreach my $pinid (qw( title title.textonly page head template ))
	{
		my $pin = $self->utf8_pin( $pinid );
		next if $pin eq "";

		open(my $fh, ">:utf8", "$prefix.$pinid") or die "Error writing to $prefix.$pinid: $!";
		print $fh $pin;
		close($fh);
		push @r, "$prefix.$pinid";
	}

	return @r;
}

>>>>>>> 2b6259f2290a0e66c6dd1d800751684d72f6aaf6
1;


=head1 COPYRIGHT

=for COPYRIGHT BEGIN

<<<<<<< HEAD
Copyright 2000-2011 University of Southampton.
=======
Copyright 2000-2012 University of Southampton.
>>>>>>> 2b6259f2290a0e66c6dd1d800751684d72f6aaf6

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

