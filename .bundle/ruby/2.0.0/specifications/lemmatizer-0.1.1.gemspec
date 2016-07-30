# -*- encoding: utf-8 -*-
# stub: lemmatizer 0.1.1 ruby lib

Gem::Specification.new do |s|
  s.name = "lemmatizer"
  s.version = "0.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Yoichiro Hasebe"]
  s.date = "2013-11-03"
  s.description = "\n    Lemmatizer for text in English. Inspired by Python's nltk.corpus.reader.wordnet.morphy package.\n  "
  s.email = ["yohasebe@gmail.com"]
  s.homepage = "http://github.com/yohasebe/lemmatizer"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.4.1"
  s.summary = "Englsh lemmatizer in Ruby"

  s.installed_by_version = "2.4.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>, [">= 0"])
    else
      s.add_dependency(%q<rspec>, [">= 0"])
    end
  else
    s.add_dependency(%q<rspec>, [">= 0"])
  end
end
