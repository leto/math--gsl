eval 'use Test::Pod 1.00';
if ($@){
	print "Test::Pod 1.00 required for testing POD\n";
} else {
	all_pod_files_ok();
}
