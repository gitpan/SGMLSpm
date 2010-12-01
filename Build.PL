use warnings;
use strict;

use Module::Build;

my $build = Module::Build->new
 (
  module_name => "SGMLSpm",
  dist_version_from => 'lib/SGMLS.pm',
  license => 'gpl',
  dist_author => "David Megginson",
  dist_abstract => "a perl5 class library for parsing the output from James Clark's SGMLS and NSGMLS parsers.",
  create_makefile_pl => 'traditional',
  script_files =>  [ qw(script/sgmlspl.pl) ]
 );

$build->add_build_element('pl');
$build->create_build_script();




