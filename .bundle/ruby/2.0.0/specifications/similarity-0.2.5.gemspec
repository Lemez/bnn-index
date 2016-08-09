# -*- encoding: utf-8 -*-
# stub: similarity 0.2.5 ruby lib

Gem::Specification.new do |s|
  s.name = "similarity"
  s.version = "0.2.5"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Chris Lowis"]
  s.date = "2011-05-25"
  s.description = "Document similarity calculations using cosine similarity and TF-IDF weights\n"
  s.email = "chris.lowis@bbc.co.uk"
  s.homepage = ""
  s.rubyforge_project = "similarity"
  s.rubygems_version = "2.4.1"
  s.summary = "Document similarity calculations using cosine similarity and TF-IDF weights"

  s.installed_by_version = "2.4.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<gsl>, [">= 0"])
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<faker>, [">= 0"])
      s.add_development_dependency(%q<ruby-graphviz>, [">= 0"])
    else
      s.add_dependency(%q<gsl>, [">= 0"])
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<faker>, [">= 0"])
      s.add_dependency(%q<ruby-graphviz>, [">= 0"])
    end
  else
    s.add_dependency(%q<gsl>, [">= 0"])
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<faker>, [">= 0"])
    s.add_dependency(%q<ruby-graphviz>, [">= 0"])
  end
end
