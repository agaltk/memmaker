# -*- encoding: utf-8 -*-
# stub: ruby-jmeter 2.1.7 ruby lib

Gem::Specification.new do |s|
  s.name = "ruby-jmeter"
  s.version = "2.1.7"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Tim Koopmans"]
  s.date = "2013-11-09"
  s.description = "This is a Ruby based DSL for writing JMeter test plans"
  s.email = ["support@flood.io"]
  s.executables = ["grid"]
  s.files = ["bin/grid"]
  s.homepage = "http://flood-io.github.io/ruby-jmeter/"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "2.1.11"
  s.summary = "This is a Ruby based DSL for writing JMeter test plans"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rest-client>, [">= 0"])
      s.add_runtime_dependency(%q<nokogiri>, [">= 0"])
    else
      s.add_dependency(%q<rest-client>, [">= 0"])
      s.add_dependency(%q<nokogiri>, [">= 0"])
    end
  else
    s.add_dependency(%q<rest-client>, [">= 0"])
    s.add_dependency(%q<nokogiri>, [">= 0"])
  end
end
