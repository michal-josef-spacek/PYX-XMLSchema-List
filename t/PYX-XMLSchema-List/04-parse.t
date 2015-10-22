# Pragmas.
use strict;
use warnings;

# Modules.
use File::Object;
use PYX::XMLSchema::List;
use Perl6::Slurp qw(slurp);
use Test::More 'tests' => 3;
use Test::NoWarnings;
use Test::Output;

# Directories.
my $data_dir = File::Object->new->up->dir('data');

# Test.
my $obj = PYX::XMLSchema::List->new;
my $pyx_data = slurp($data_dir->file('ex1.pyx')->s);
my $right_ret = <<"END";
No XML schemas.
END
stdout_is(
	sub {
		$obj->parse($pyx_data);
		return;
	},
	$right_ret,
	'Parse data from ex1.pyx file.',
);

# Test.
$right_ret = <<'END';
[ bar ] (E: 0000, A: 0001) http://bar.foo
[ foo ] (E: 0001, A: 0001) http://foo.bar
[ xml ] (E: 0000, A: 0001)
END
$pyx_data = slurp($data_dir->file('ex2.pyx')->s);
stdout_is(
	sub {
		$obj->parse($pyx_data);
		return;
	},
	$right_ret,
	'Parse data from ex2.pyx file.',
);
