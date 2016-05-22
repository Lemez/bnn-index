# -*- encoding: utf-8 -*-
# stub: pluck_to_hash 0.1.4 ruby lib

Gem::Specification.new do |s|
  s.name = "pluck_to_hash"
  s.version = "0.1.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Girish S"]
  s.date = "2016-05-16"
  s.description = "Extend ActiveRecord pluck to return hash instead of an array. Useful when plucking multiple columns."
  s.email = ["girish.sonawane@gmail.com"]
  s.homepage = "https://github.com/girishso/pluck_to_hash"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.4.1"
  s.summary = "Extend ActiveRecord pluck to return hash"

  s.installed_by_version = "2.4.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<bundler>, ["~> 1.7"])
      s.add_development_dependency(%q<rake>, ["~> 10.0"])
      s.add_development_dependency(%q<sqlite3>, ["~> 1.3"])
      s.add_development_dependency(%q<rspec>, ["~> 3.2"])
      s.add_runtime_dependency(%q<activerecord>, [">= 4.0.2"])
    else
      s.add_dependency(%q<bundler>, ["~> 1.7"])
      s.add_dependency(%q<rake>, ["~> 10.0"])
      s.add_dependency(%q<sqlite3>, ["~> 1.3"])
      s.add_dependency(%q<rspec>, ["~> 3.2"])
      s.add_dependency(%q<activerecord>, [">= 4.0.2"])
    end
  else
    s.add_dependency(%q<bundler>, ["~> 1.7"])
    s.add_dependency(%q<rake>, ["~> 10.0"])
    s.add_dependency(%q<sqlite3>, ["~> 1.3"])
    s.add_dependency(%q<rspec>, ["~> 3.2"])
    s.add_dependency(%q<activerecord>, [">= 4.0.2"])
  end
end
