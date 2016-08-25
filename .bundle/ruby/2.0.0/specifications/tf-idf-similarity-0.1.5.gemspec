# -*- encoding: utf-8 -*-
# stub: tf-idf-similarity 0.1.5 ruby lib

Gem::Specification.new do |s|
  s.name = "tf-idf-similarity"
  s.version = "0.1.5"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["James McKinney"]
  s.date = "2016-01-18"
  s.homepage = "https://github.com/jpmckinney/tf-idf-similarity"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.4.1"
  s.summary = "Calculates the similarity between texts using tf*idf"

  s.installed_by_version = "2.4.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<unicode_utils>, ["~> 1.4"])
      s.add_development_dependency(%q<coveralls>, [">= 0"])
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<rspec>, ["~> 2.10"])
    else
      s.add_dependency(%q<unicode_utils>, ["~> 1.4"])
      s.add_dependency(%q<coveralls>, [">= 0"])
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<rspec>, ["~> 2.10"])
    end
  else
    s.add_dependency(%q<unicode_utils>, ["~> 1.4"])
    s.add_dependency(%q<coveralls>, [">= 0"])
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<rspec>, ["~> 2.10"])
  end
end
