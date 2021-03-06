use strict;
use Test::More;

BEGIN {
	eval "require XML::GDOME";
	if( $@ )
	{
		plan skip_all => "XML::GDOME missing";
	}
	else
	{
<<<<<<< HEAD
		plan tests => 12;
=======
		plan tests => 14;
>>>>>>> 2b6259f2290a0e66c6dd1d800751684d72f6aaf6
	}
}

use EPrints::SystemSettings;
$EPrints::SystemSettings::conf->{enable_gdome} = 1;
$EPrints::SystemSettings::conf->{enable_libxml} = 0;
use_ok( "EPrints" );
use_ok( "EPrints::Test" );
use_ok( "EPrints::Test::XML" );
$EPrints::XML::CLASS = $EPrints::XML::CLASS; # suppress used-only-once warning
BAIL_OUT( "Didn't load expected XML library" )
	if $EPrints::XML::CLASS ne "EPrints::XML::GDOME";

my $repo = EPrints::Test::get_test_repository();

&EPrints::Test::XML::xml_tests( $repo );

ok(1);
