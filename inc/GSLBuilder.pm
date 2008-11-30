package GSLBuilder;
use Config;
use File::Copy;
use File::Path qw/mkpath/;
use File::Spec::Functions qw/:ALL/;
use Data::Dumper;
use base 'Module::Build';

sub is_release {
    return -e '.git' ? 0 : 1;
}
sub subsystems {   
    sort qw/
        Diff         Machine      Statistics    BLAS
        Eigen        Matrix       Poly          MatrixComplex
        BSpline      Errno        PowInt        VectorComplex
        CBLAS        FFT          Min           IEEEUtils
        CDF          Fit          QRNG
        Chebyshev    Monte        RNG           Vector
        Heapsort     Multifit     Randist       Roots     
        Combination  Histogram    Multimin      Wavelet
        Complex      Histogram2D  Multiroots    Wavelet2D
        Const        Siman        Sum           Sys
        NTuple       Integration  Sort          Test        
        DHT          Interp       ODEIV         SF 
        Deriv        Linalg       Permutation   Spline
    /;
}

sub process_swig_files {
    my $self = shift;
    my $p = $self->{properties};


    return unless $p->{swig_source};
    my $files_ref = $p->{swig_source};
    foreach my $file (@$files_ref) {
        $self->process_swig($file->[0], $file->[1]);
    }
}

# Check check dependencies for $main_swig_file. These are the
# %includes. If needed, arrange to run swig on $main_swig_file to
# produce a xxx_wrap.c C file.

sub process_swig {
    my ($self, $main_swig_file, $deps_ref) = @_;
    my ($cf, $p) = ($self->{config}, $self->{properties});

    (my $file_base = $main_swig_file) =~ s/\.[^.]+$//;
    $file_base =~ s!swig/!!g;
    my $c_file = catdir('xs',"${file_base}_wrap.c");

    my @deps = defined $deps_ref ?  @$deps_ref : (); 

    # don't bother with swig if this is a CPAN release
    unless ( is_release() ) {
        $self->compile_swig($main_swig_file, $c_file) 
                unless($self->up_to_date( [$main_swig_file, @deps],$c_file)); 
    }
    # .c -> .o
    my $obj_file = $self->compile_c($c_file);
    $self->add_to_cleanup($obj_file);

    my $archdir = catdir($self->blib, qw/arch auto Math GSL/, $file_base);
    mkpath $archdir unless -d $archdir;

    # .o -> .so
    $self->link_c($archdir, $file_base, $obj_file);
}

# Invoke swig with -perl -outdir and other options.
sub compile_swig {
    my ($self, $file, $c_file) = @_;
    my ($cf, $p) = ($self->{config}, $self->{properties}); # For convenience

    # File name, minus the suffix
    (my $file_base = $file) =~ s/\.[^.]+$//;

    # get rid of the swig name
    $file_base =~ s!swig/!!g;

    my $pm_file = "${file_base}.pm";
    
    my @swig       = qw/swig/, defined($p->{swig}) ? ($self->split_like_shell($p->{swig})) : ();
    my @swig_flags = defined($p->{swig_flags}) ? $self->split_like_shell($p->{swig_flags}) : ();
   
    my $blib_lib = catfile(qw/blib lib/);
    my $gsldir   = catfile($blib_lib, qw/Math GSL/);
    mkdir $gsldir unless -e $gsldir;

    
    my $from    = catfile($gsldir, $pm_file);
    my $to      = catfile(qw/lib Math GSL/,$pm_file);
    chmod 0644, $from, $to;

    $self->do_system(@swig, '-o', $c_file ,
                     '-outdir', $gsldir, 
		             '-perl5', @swig_flags, $file)
	    or die "error : $! while building ( @swig_flags ) $c_file in $gsl_dir from '$file'";
    print "Copying from: $from, to: $to; it makes the CPAN indexer happy.\n";
    copy($from,$to);
    return $c_file;
}
sub is_windows { $^O =~ /MSWin32/i }
sub is_darwin  { $^O =~ /darwin/i  }

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

    push @linker_flags, $Config{archlib} . '/CORE/' . $Config{libperl} if (is_windows() or is_darwin());

    my @lddlflags = $self->split_like_shell($cf->{lddlflags}); 
    my @shrp = $self->split_like_shell($cf->{shrpenv});
    my @ld = $self->split_like_shell($cf->{ld}) || "gcc";

    # Strip binaries if we are compiling on windows
    push @ld, "-s" if (is_windows() && $Config{cc} eq 'gcc');

    $self->do_system(@shrp, @ld, @lddlflags, @user_libs, '-o', $lib_file ,
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

  my @cccdlflags = $self->split_like_shell($cf->{cccdlflags});

  my @ccflags  = $self->split_like_shell($cf->{ccflags});
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
  @cc = "gcc" unless @cc;
  
  $self->do_system(@cc, @flags, '-o', $obj_file, $file)
    or die "error building $Config{_o} file from '$file'";

  return $obj_file;
}

3.14;
