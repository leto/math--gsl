# Uploading a new CPAN distribution

## Bump version number in `Math/GSL.pm`

- Edit the file `lib/Math/GSL.pm` and change the version number at
line 29:

```
our $VERSION = '0.41';  # <-- increase the version number
```

and in the Pod at line 37.

## Update copyright year in Pod files

```
cd developer/bin
./update_copyright.pl
```

## Update Changes file

Update the `Changes` file.

## Build the CPAN distribution

```
cd developer/docker
./build_image.sh
./run.sh 2.6  # <-- Uses GSL version 2.6 to build the distribution
```
after `run.sh` there should be a distribution tarball
`Math-GSL-xx.yy.tar.gz`, in the current directory. Here, xx.yy
corresponds the current version, i.e., `$Math::GSL::VERSION`.

## Upload the distribution

- Go to the PAUSE upload server

https://pause.perl.org/pause/authenquery?ACTION=add_uri

and upload the generated tarball (e.g. `Math-GSL-0.41.tar.gz`)
