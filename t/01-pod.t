use Test::More tests => 1;
eval 'use Test::Pod 1.00';
if ($@){
    ok(1, 'Test::Pod 1.00 required for testing POD') 
} else {
    all_pod_files_ok();
}
