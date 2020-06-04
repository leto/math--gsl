# Uploading a new CPAN distribution

## Bump version number in `Math/GSL.pm`

- Edit the file `lib/Math/GSL.pm` and change the version number at
line 29:

```
our $VERSION = '0.41';  # <-- increase the version number
```

## Build the CPAN distribution

```
cd docker 
./build_image.sh
./run.sh 2.6  # <-- Uses GSL version 2.6 to build the distribution
```
after `run.sh` finishes you are left in the bash shell of the docker
container with a file `Math-GSL-xx.yy.tar.gz`, where xx.yy corresponds
to the version you chose in the previous step.

## Upload the distribution

- Go to the PAUSE upload server

https://pause.perl.org/pause/authenquery?ACTION=add_uri

and upload the generated tarball (e.g. `Math-GSL-0.41.tar.gz`)
