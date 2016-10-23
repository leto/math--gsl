package GSLBuilder;

use strict;
use warnings;

use Config;
use File::Copy;
use File::Path qw/mkpath/;
use File::Spec::Functions qw/:ALL/;
use base 'Module::Build';

sub is_release {
    return -e '.git' ? 0 : 1;
}

# Only subsystems that existed in GSL 1.15 are listed here
# update inc/GSLBuilder.pm and Build.PL to add others
sub subsystems {
    sort qw/
        Diff         Machine      Statistics    BLAS
        Eigen        Matrix       Poly          MatrixComplex
        BSpline      Errno        PowInt        VectorComplex
        CBLAS        FFT          Min           IEEEUtils
        CDF          Fit          QRNG
        Chebyshev    Monte        RNG           Vector
        Heapsort     Randist      Roots
        Combination  Histogram    Multimin      Wavelet
        Complex      Histogram2D  Multiroots    Wavelet2D
        Const        Siman        Sum           Sys
        NTuple       Integration  Sort          Test
        DHT          Interp       ODEIV         SF
        Deriv        Linalg       Permutation   Spline
        Version      Multiset
    /;
}

sub c_modules {
    my @c = qw/Matrix Randist/;
    return +{ map {($_ => 1)} @c };
}

sub process_swig_files {
    my $self = shift;
    my $p = $self->{properties};

    my $files_ref = $p->{swig_source};
    return unless ($files_ref);

    unless (is_release()) {
        $self->process_versioned_swig_files;
    }

    my $binding_ver     = $self->get_binding_version;
    my $current_version = $self->{properties}->{current_version};
    my $gsl_prefix      = $self->{properties}->{gsl_prefix};
    my $gsl_ldflags     = $self->{properties}->{extra_linker_flags};
    my $gsl_ccflags     = $self->{properties}->{extra_compiler_flags};
    my $swig_flags      = $self->{properties}->{swig_flags};
    my $swig_version    = $self->{properties}->{swig_version};

    if ($binding_ver ne $current_version) {
        print "VERSION MISMATCH: Let's hope for the best.\n";
    }
    print "Processing $binding_ver XS files, GSL $current_version (via gsl-config) at $gsl_prefix\n";
    print "Compiler        = " . qx{ $Config{cc} --version } . "\n";
    print "ccflags         = @$gsl_ccflags\n";
    print "ldflags         = @$gsl_ldflags\n";
    print "swig_flags      = $swig_flags\n" unless is_release();
    print "swig_version    = $swig_version\n" unless is_release();
    my $PERL5LIB           = $ENV{PERL5LIB} || "";
    my $LD_LIBRARY_PATH    = $ENV{LD_LIBRARY_PATH} || "";
    print "PERL5LIB        = $PERL5LIB\n";
    print "LD_LIBRARY_PATH =$LD_LIBRARY_PATH\n";

    foreach my $file (@$files_ref) {
        $self->process_xs_file($file->[0], $binding_ver);
    }
}

sub get_binding_version {
    my $self = shift;
    my $current_version = $self->{properties}->{current_version};
    my @bindings = <xs/*>;
    my $all_binding_versions = {};
    foreach my $b (@bindings) {
        if ($b =~ /\w(?:\d+)?\.([\d\.]+)\.c$/) {
            $all_binding_versions->{$1} = 1;
        }
    }
    my $result_binding_version;

    # make sure we find 2.2.1 before 2.2
    foreach my $b_ver (reverse sort keys %{$all_binding_versions}) {
        if (cmp_versions($current_version, $b_ver) >= 0 &&
            (!defined($result_binding_version) ||
             cmp_versions($result_binding_version, $b_ver) == -1))
        {
            $result_binding_version = $b_ver;
        }
    }

    unless (defined($result_binding_version)) {
        die "Can't find appropriate bindings version, ".
            "check 'xs' directory, it should contains bindings " .
            "with version <= current GSL version ($current_version)";
    }

    return $result_binding_version;
}

sub process_versioned_swig_files {
    my $self = shift;

    my $p = $self->{properties};
    my $files_ref = $p->{swig_source};

    my $cur_ver = $p->{current_version};
    my $ver2func = $p->{ver2func};

    foreach my $ver (sort {cmp_versions($a, $b)} keys %{$ver2func}) {
        next if (cmp_versions($cur_ver, $ver) == -1);
        my @renames;
        foreach my $high_ver (keys %{$ver2func}) {
            next if (cmp_versions($high_ver, $ver) < 1);
            push @renames, @{$ver2func->{$high_ver}};
        }
        print "Building wrappers for GSL $ver\n";
        my $renames_fname = catfile(qw/swig renames.i/);
        open(my $fh, '>', $renames_fname)
            or die "Could not create $renames_fname: $!";
        foreach my $rename (@renames) {
            print $fh q{%rename("%(regex:/} . $rename . q{/$ignore/)s") "";} . "\n";
        }
        close($fh) or die "Could not close $renames_fname: $!";

        foreach my $file (@$files_ref) {
            my ($major,$minor,$tiny) = split /\./, $ver;
            # don't create lots of XS for subsystems that didn't exist
            # in old GSL versions
            if ($file->[0] =~ m/Multilarge/ or $file->[0] =~ m/Multifit/) {
                if ($major >=2 && $minor >= 1) {
                    $self->process_swig($file->[0], $file->[1], $ver);
                }
            } elsif ($file->[0] =~ m/(Rstat|SparseMatrix)/) {
                if ($major >=2 ) {
                    $self->process_swig($file->[0], $file->[1], $ver);
                }
            } else {
                $self->process_swig($file->[0], $file->[1], $ver);
            }
        }
    }
}

sub process_xs_file {
    my ($self, $main_swig_file, $ver) = @_;

    (my $file_base = $main_swig_file) =~ s/\.[^.]+$//;
    $file_base =~ s!\\!/!g;
    (undef, undef, $file_base) = splitpath($file_base);

    my $c_file = catfile('xs',"${file_base}_wrap.$ver.c");

    # .c -> .o
    my $obj_file = $self->compile_c($c_file);
    $self->add_to_cleanup($obj_file);

    my $archdir = catdir($self->blib, qw/arch auto Math GSL/, $file_base);
    mkpath $archdir unless -d $archdir;

    # .o -> .so
    $self->link_c($archdir, $file_base, $obj_file);

    my $from = catfile(qw/pm Math GSL/, "${file_base}.pm.$ver");
    my $to = catfile(qw/blib lib Math GSL/, "${file_base}.pm");
    chmod 0644, $from, $to;
    copy($from, $to);
}

sub cmp_versions {
    my ($v1, $v2) = @_;
    my @v1 = split(/\./, $v1);
    my @v2 = split(/\./, $v2);
    my $cmp_major = $v1[0] <=> $v2[0];
    return $cmp_major if ($cmp_major != 0);
    my $cmp_minor = $v1[1] <=> $v2[1];
    return $cmp_minor;
}

# Check dependencies for $main_swig_file. These are the
# %includes. If needed, arrange to run swig on $main_swig_file to
# produce a xxx_wrap.c C file.
sub process_swig {
    my ($self, $main_swig_file, $deps_ref, $ver) = @_;
    my ($cf, $p) = ($self->{config}, $self->{properties});

    (my $file_base = $main_swig_file) =~ s/\.[^.]+$//;
    $file_base =~ s!swig/!!g;
    my $c_file = catfile('xs',"${file_base}_wrap.$ver.c");

    my @deps = defined $deps_ref ?  @$deps_ref : ();

    # don't bother with swig if this is a CPAN release
    $self->compile_swig($main_swig_file, $c_file, $ver)
        unless $self->up_to_date([$main_swig_file, @deps], $c_file);
}

sub swig_binary_name {
    # recent versions of Ubuntu call it swig2.0 . Le sigh.
    my $cmd = "swig -version";
    my $out  = eval { no warnings; `$cmd` };
    if ($?) {
        $cmd = "swig2.0 -version";
        $out = eval { no warnings; `$cmd` };

        if ($?) {
            die "Can't find the swig binary!";
        } else {
            return "swig2.0";
        }
    }
    return "swig";
}

# Invoke swig with -perl -outdir and other options.
sub compile_swig {
    my ($self, $file, $c_file, $ver) = @_;
    my ($cf, $p) = ($self->{config}, $self->{properties}); # For convenience

    # File name, minus the suffix
    (my $file_base = $file) =~ s/\.[^.]+$//;

    # get rid of the swig name
    $file_base =~ s!swig/!!g;

    my $pm_file = "${file_base}.pm";

    my @swig       = swig_binary_name(), defined($p->{swig}) ? ($self->split_like_shell($p->{swig})) : ();
    my @swig_flags = defined($p->{swig_flags}) ? $self->split_like_shell($p->{swig_flags}) : ();

    my $blib_lib = catdir(qw/blib lib/);
    my $gsldir = catdir('pm', qw/Math GSL/);
    mkpath $gsldir unless -e $gsldir;

    my $from    = catfile($gsldir, $pm_file);
    my $to      = catfile(qw/lib Math GSL/, $pm_file);
    chmod 0644, $from, $to;

    my @args = ( @swig, '-o', $c_file , '-outdir', $gsldir, '-perl5', @swig_flags, $file);
    print join(" ", @args ) . "\n";
    $self->do_system( @args ) or die "error : $! while building ( @swig_flags ) $c_file in $gsldir from '$file'";
    move($from, "$from.$ver");

    {
      ## updates the version number.
      ## all files are being processed right now.
      ## later versions might use a fixed list of candidate files.
      undef $/;
      open my $in, "<", $c_file or die "Can't open file $c_file: $!";
      my $contents = <$in>;
      close $in;

      # TODO: this doesn't support x.y.z
      $contents =~ s{("GSL_VERSION", TRUE \| 0x2 \| GV_ADDMULTI\);[\s\n]*sv_setsv\(sv, SWIG_FromCharPtr\(")\d\.\d+}
                    {$1$ver};

      open my $out, ">", $c_file or die "Can't overwrite file $c_file: $!";
      print $out $contents;
      close $out;
    }

    if ($p->{current_version} eq $ver) {
        # print "Copying from: $from.$ver, to: $to; it makes the CPAN indexer happy.\n";
        copy("$from.$ver", $to);
    }

   return $c_file;
}
sub is_windows { $^O =~ /MSWin32/i }
sub is_darwin  { $^O =~ /darwin/i  }
sub is_cygwin  { $^O =~ /cygwin/i }

# Windows fixes courtesy of <sisyphus@cpan.org>
sub link_c {
  my ($self, $to, $file_base, $obj_file) = @_;
  my ($cf, $p) = ($self->{config}, $self->{properties}); # For convenience

  my $lib_file = catfile($to, File::Basename::basename("$file_base.$Config{dlext}"));
  # this is so Perl can look for things in the standard directories
  $lib_file =~ s!swig/!!g;

  $self->add_to_cleanup($lib_file);
  my $objects = $p->{objects} || [];

  unless ($self->up_to_date([$obj_file, @$objects], $lib_file)) {
    my @linker_flags = $self->split_like_shell($p->{extra_linker_flags});
    push @linker_flags, "-v" if $ENV{DEBUG_LD};

    if(is_windows() or is_darwin()) {
      if(is_windows() && $] eq '5.010000' && $Config{archname} =~ /x64/) {
         push @linker_flags, $Config{bin} . '/' . $Config{libperl};
      }
      else {
        push @linker_flags, $Config{archlib} . '/CORE/' . $Config{libperl};
      }
    }

    my @lddlflags = $self->split_like_shell($cf->{lddlflags});
    my @shrp      = $self->split_like_shell($cf->{shrpenv});
    my @ld        = $self->split_like_shell($cf->{ld} || $Config{cc});

    # Strip binaries if we are compiling on windows
    push @ld, "-s" if (is_windows() && $Config{cc} =~ /\bgcc\b/i);

    print join(" ", @shrp, @ld, @lddlflags, '-o', $lib_file, $obj_file, @$objects, @linker_flags) . "\n";
    $self->do_system(@shrp, @ld, @lddlflags, '-o', $lib_file,
		     $obj_file, @$objects, @linker_flags)
      or die "error building $lib_file file from '$obj_file'";
  }

  return $lib_file;
}

# From Base.pm but modified to put package cflags *after*
# installed c flags so warning-removal will have an effect.

sub compile_c {
  my ($self, $file) = @_;
  my ($cf, $p) = ($self->{config}, $self->{properties}); # For convenience

  # File name, minus the suffix
  (my $file_base = $file) =~ s/\.[^.]+$//;
  my $obj_file = $file_base . $Config{_o};

  $self->add_to_cleanup($obj_file);
  return $obj_file if $self->up_to_date($file, $obj_file);

  $cf->{installarchlib} = $Config{archlib};

  my @include_dirs = @{$p->{include_dirs}}
			? map {"-I$_"} (@{$p->{include_dirs}}, catdir($cf->{installarchlib}, 'CORE'))
			: map {"-I$_"} ( catdir($cf->{installarchlib}, 'CORE') ) ;

  my @extra_compiler_flags = $self->split_like_shell($p->{extra_compiler_flags});
  my @cccdlflags           = $self->split_like_shell($cf->{cccdlflags});
  my @ccflags              = $self->split_like_shell($cf->{ccflags});

  push @ccflags, $self->split_like_shell($Config{cppflags});
  my @optimize = $self->split_like_shell($cf->{optimize});

  # Whoah! There seems to be a bug in gcc 4.1.0 and optimization
  # and swig. I'm not sure who's at fault. But for now the simplest
  # thing is to turn off all optimization. For the kinds of things that
  # SWIG does - do conversions between parameters and transfers calls
  # I doubt optimization makes much of a difference. But if it does,
  # it can be added back via @extra_compiler_flags.

  my @flags = (@include_dirs, @cccdlflags, '-c', @ccflags, @extra_compiler_flags, );

  my @cc = $self->split_like_shell($cf->{cc});
  @cc = $self->split_like_shell($Config{cc}) unless @cc;
  print join(" ", @cc, @flags, '-o', $obj_file, $file) . "\n";
  $self->do_system(@cc, @flags, '-o', $obj_file, $file)
    or die "error building $Config{_o} file from '$file'";

  return $obj_file;
}

# Propagate version numbers to all modules
sub get_metadata {
    my ($self, @args) = @_;
    my $data = $self->SUPER::get_metadata(@args);
    for my $mod (values %{$data->{provides}}) {
        $mod->{version} ||= 0;
    }
    return $data;
}

3.14;
