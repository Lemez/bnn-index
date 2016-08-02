# -*- encoding: utf-8 -*-
# stub: sentimental 1.4.0 ruby lib

Gem::Specification.new do |s|
  s.name = "sentimental"
  s.version = "1.4.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Jeff Emminger", "Christopher MacLellan", "Denis Pasin"]
  s.date = "2016-05-19"
  s.description = "A simple sentiment analysis gem"
  s.email = ["jeff@7compass.com", "denis@hellojam.fr"]
  s.homepage = "https://github.com/7compass/sentimental"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.4.1"
  s.summary = "Simple sentiment analysis"

  s.installed_by_version = "2.4.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<bundler>, ["~> 1.3"])
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<rspec>, [">= 3.0.0"])
      s.add_development_dependency(%q<rubocop>, [">= 0.40.0", "~> 0.40"])
      s.add_runtime_dependency(%q<json>, [">= 1.8.3", "~> 1.8"])
    else
      s.add_dependency(%q<bundler>, ["~> 1.3"])
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<rspec>, [">= 3.0.0"])
      s.add_dependency(%q<rubocop>, [">= 0.40.0", "~> 0.40"])
      s.add_dependency(%q<json>, [">= 1.8.3", "~> 1.8"])
    end
  else
    s.add_dependency(%q<bundler>, ["~> 1.3"])
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<rspec>, [">= 3.0.0"])
    s.add_dependency(%q<rubocop>, [">= 0.40.0", "~> 0.40"])
    s.add_dependency(%q<json>, [">= 1.8.3", "~> 1.8"])
  end
end
