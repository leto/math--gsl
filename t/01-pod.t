eval 'use Test::Pod 1.00';
use Test::More 'no_plan';
if ($@){
	print "Test::Pod 1.00 required for testing POD\n";
    ok(1);
} else {
	all_pod_files_ok();
}
