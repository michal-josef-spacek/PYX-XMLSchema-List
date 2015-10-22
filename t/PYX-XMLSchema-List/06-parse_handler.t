# Pragmas.
use strict;
use warnings;

# Modules.
use File::Object;
use PYX::XMLSchema::List;
use Test::More 'tests' => 3;
use Test::NoWarnings;
use Test::Output;

# Directories.
my $data_dir = File::Object->new->up->dir('data');

# Test.
my $obj = PYX::XMLSchema::List->new;
my $right_ret = <<"END";
No XML schemas.
END
open my $pyx_handler, '<', $data_dir->file('ex1.pyx')->s;
stdout_is(
	sub {
		$obj->parse_handler($pyx_handler);
		return;
	},
	$right_ret,
	'Parse ex1.pyx file handler.',
);
close $pyx_handler;

# Test.
$right_ret = <<'END';
[ bar ] (E: 0000, A: 0001) http://bar.foo
[ foo ] (E: 0001, A: 0001) http://foo.bar
[ xml ] (E: 0000, A: 0001)
END
open $pyx_handler, '<', $data_dir->file('ex2.pyx')->s;
stdout_is(
	sub {
		$obj->parse_handler($pyx_handler);
		return;
	},
	$right_ret,
	'Parse ex2.pyx file handler.',
);
