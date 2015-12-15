<<<<<<< HEAD
######################################################################
#
# EPrints::TempDir
#
######################################################################
#
#
######################################################################

=======
>>>>>>> 2b6259f2290a0e66c6dd1d800751684d72f6aaf6
package EPrints::TempDir;

use File::Temp;

use strict;

<<<<<<< HEAD
=pod
=======
=for Pod2Wiki
>>>>>>> 2b6259f2290a0e66c6dd1d800751684d72f6aaf6

=head1 NAME

EPrints::TempDir - Create temporary directories that are removed automatically

=head1 DESCRIPTION

DEPRECATED

<<<<<<< HEAD
Use C<<File::Temp->newdir()>>;
=======
Use C<< File::Temp->newdir() >>
>>>>>>> 2b6259f2290a0e66c6dd1d800751684d72f6aaf6

=head1 SEE ALSO

L<File::Temp>

=cut

sub new
{
	my $class = shift;

	return File::Temp->newdir( @_, TMPDIR => 1 );
}

1;

__END__

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

