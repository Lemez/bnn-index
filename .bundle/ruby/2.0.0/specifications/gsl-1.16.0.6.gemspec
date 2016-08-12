# -*- encoding: utf-8 -*-
# stub: gsl 1.16.0.6 ruby lib
# stub: ext/gsl_native/extconf.rb

Gem::Specification.new do |s|
  s.name = "gsl"
  s.version = "1.16.0.6"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Yoshiki Tsunesada", "David MacMahon", "Jens Wille", "Daniel Mendler"]
  s.date = "2015-07-03"
  s.description = "Ruby/GSL is a Ruby interface to the GNU Scientific Library, for numerical computing with Ruby"
  s.email = "mail@daniel-mendler.de"
  s.extensions = ["ext/gsl_native/extconf.rb"]
  s.extra_rdoc_files = ["rdoc/start.rdoc", "rdoc/monte.rdoc", "rdoc/hist3d.rdoc", "rdoc/ntuple.rdoc", "rdoc/ndlinear.rdoc", "rdoc/complex.rdoc", "rdoc/dht.rdoc", "rdoc/odeiv.rdoc", "rdoc/perm.rdoc", "rdoc/const.rdoc", "rdoc/nonlinearfit.rdoc", "rdoc/tensor.rdoc", "rdoc/linalg_complex.rdoc", "rdoc/eigen.rdoc", "rdoc/siman.rdoc", "rdoc/function.rdoc", "rdoc/min.rdoc", "rdoc/cholesky_complex.rdoc", "rdoc/qrng.rdoc", "rdoc/multiroot.rdoc", "rdoc/blas.rdoc", "rdoc/wavelet.rdoc", "rdoc/hist.rdoc", "rdoc/math.rdoc", "rdoc/sum.rdoc", "rdoc/sf.rdoc", "rdoc/intro.rdoc", "rdoc/linalg.rdoc", "rdoc/randist.rdoc", "rdoc/tut.rdoc", "rdoc/matrix.rdoc", "rdoc/cheb.rdoc", "rdoc/rng.rdoc", "rdoc/vector_complex.rdoc", "rdoc/integration.rdoc", "rdoc/changes.rdoc", "rdoc/bspline.rdoc", "rdoc/graph.rdoc", "rdoc/alf.rdoc", "rdoc/hist2d.rdoc", "rdoc/narray.rdoc", "rdoc/ref.rdoc", "rdoc/vector.rdoc", "rdoc/diff.rdoc", "rdoc/stats.rdoc", "rdoc/interp.rdoc", "rdoc/multimin.rdoc", "rdoc/poly.rdoc", "rdoc/roots.rdoc", "rdoc/use.rdoc", "rdoc/combi.rdoc", "rdoc/fit.rdoc", "rdoc/sort.rdoc", "rdoc/fft.rdoc", "rdoc/ehandling.rdoc"]
  s.files = ["ext/gsl_native/extconf.rb", "rdoc/alf.rdoc", "rdoc/blas.rdoc", "rdoc/bspline.rdoc", "rdoc/changes.rdoc", "rdoc/cheb.rdoc", "rdoc/cholesky_complex.rdoc", "rdoc/combi.rdoc", "rdoc/complex.rdoc", "rdoc/const.rdoc", "rdoc/dht.rdoc", "rdoc/diff.rdoc", "rdoc/ehandling.rdoc", "rdoc/eigen.rdoc", "rdoc/fft.rdoc", "rdoc/fit.rdoc", "rdoc/function.rdoc", "rdoc/graph.rdoc", "rdoc/hist.rdoc", "rdoc/hist2d.rdoc", "rdoc/hist3d.rdoc", "rdoc/integration.rdoc", "rdoc/interp.rdoc", "rdoc/intro.rdoc", "rdoc/linalg.rdoc", "rdoc/linalg_complex.rdoc", "rdoc/math.rdoc", "rdoc/matrix.rdoc", "rdoc/min.rdoc", "rdoc/monte.rdoc", "rdoc/multimin.rdoc", "rdoc/multiroot.rdoc", "rdoc/narray.rdoc", "rdoc/ndlinear.rdoc", "rdoc/nonlinearfit.rdoc", "rdoc/ntuple.rdoc", "rdoc/odeiv.rdoc", "rdoc/perm.rdoc", "rdoc/poly.rdoc", "rdoc/qrng.rdoc", "rdoc/randist.rdoc", "rdoc/ref.rdoc", "rdoc/rng.rdoc", "rdoc/roots.rdoc", "rdoc/sf.rdoc", "rdoc/siman.rdoc", "rdoc/sort.rdoc", "rdoc/start.rdoc", "rdoc/stats.rdoc", "rdoc/sum.rdoc", "rdoc/tensor.rdoc", "rdoc/tut.rdoc", "rdoc/use.rdoc", "rdoc/vector.rdoc", "rdoc/vector_complex.rdoc", "rdoc/wavelet.rdoc"]
  s.homepage = "http://github.com/SciRuby/rb-gsl"
  s.licenses = ["GPL-2.0"]
  s.post_install_message = "gsl can be installed with or without narray support. Please install narray before and reinstall gsl if it is missing."
  s.rdoc_options = ["--title", "Ruby/GSL (1.16.0.6)", "--charset", "UTF-8", "--line-numbers", "--all", "--main", "index.rdoc", "--root", "rdoc"]
  s.required_ruby_version = Gem::Requirement.new(">= 1.9.3")
  s.requirements = ["GSL (http://www.gnu.org/software/gsl/)"]
  s.rubygems_version = "2.4.1"
  s.summary = "Ruby interface to the GNU Scientific Library"

  s.installed_by_version = "2.4.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rake-compiler>, [">= 0"])
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<test-unit>, [">= 0"])
    else
      s.add_dependency(%q<rake-compiler>, [">= 0"])
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<test-unit>, [">= 0"])
    end
  else
    s.add_dependency(%q<rake-compiler>, [">= 0"])
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<test-unit>, [">= 0"])
  end
end
