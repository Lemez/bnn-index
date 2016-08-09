# -*- encoding: utf-8 -*-
# stub: user-agent-randomizer 0.2.0 ruby lib

Gem::Specification.new do |s|
  s.name = "user-agent-randomizer"
  s.version = "0.2.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Christoph Pilka"]
  s.date = "2014-10-22"
  s.description = ""
  s.email = ["c.pilka@asconix.com"]
  s.homepage = "https://github.com/asconix/user-agent-randomizer"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.4.1"
  s.summary = "Random HTTP User-Agent string generator"

  s.installed_by_version = "2.4.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<bundler>, ["~> 1.7"])
      s.add_development_dependency(%q<rake>, ["~> 10.3"])
      s.add_development_dependency(%q<rspec>, ["~> 3.1"])
      s.add_development_dependency(%q<nokogiri>, ["~> 1.6"])
      s.add_development_dependency(%q<simplecov>, ["~> 0.9"])
      s.add_development_dependency(%q<coveralls>, ["~> 0.7"])
    else
      s.add_dependency(%q<bundler>, ["~> 1.7"])
      s.add_dependency(%q<rake>, ["~> 10.3"])
      s.add_dependency(%q<rspec>, ["~> 3.1"])
      s.add_dependency(%q<nokogiri>, ["~> 1.6"])
      s.add_dependency(%q<simplecov>, ["~> 0.9"])
      s.add_dependency(%q<coveralls>, ["~> 0.7"])
    end
  else
    s.add_dependency(%q<bundler>, ["~> 1.7"])
    s.add_dependency(%q<rake>, ["~> 10.3"])
    s.add_dependency(%q<rspec>, ["~> 3.1"])
    s.add_dependency(%q<nokogiri>, ["~> 1.6"])
    s.add_dependency(%q<simplecov>, ["~> 0.9"])
    s.add_dependency(%q<coveralls>, ["~> 0.7"])
  end
end
