# -*- encoding: utf-8 -*-
# stub: twitter-bootswatch-rails 3.0.0.0 ruby lib

Gem::Specification.new do |s|
  s.name = "twitter-bootswatch-rails"
  s.version = "3.0.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.8.11") if s.respond_to? :required_rubygems_version=
  s.authors = ["Scott V. Rosenthal"]
  s.date = "2013-08-20"
  s.description = "twitter-bootswatch-rails gem integrates Twitter Bootstrap for Rails Asset Pipeline with less-rails"
  s.email = ["sr7575@gmail.com"]
  s.homepage = "https://github.com/scottvrosenthal/twitter-bootswatch-rails"
  s.licenses = ["MIT", "GPL-2"]
  s.post_install_message = "Important: You may need to add a javascript runtime to your Gemfile in order for bootstrap's LESS files to compile to CSS. \n\n**********************************************\n\nExecJS supports these runtimes:\n\ntherubyracer - Google V8 embedded within Ruby\n\ntherubyrhino - Mozilla Rhino embedded within JRuby\n\nNode.js\n\n**********************************************"
  s.require_paths = ["lib"]
  s.required_ruby_version = Gem::Requirement.new(">= 1.9.3")
  s.rubygems_version = "2.1.11"
  s.summary = "Twitter Bootstrap toolkit for Rails Asset Pipeline with less-rails"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<railties>, [">= 3.1"])
      s.add_runtime_dependency(%q<less-rails>, [">= 2.3"])
      s.add_runtime_dependency(%q<execjs>, [">= 1.4.0"])
      s.add_development_dependency(%q<rails>, [">= 3.1"])
      s.add_development_dependency(%q<therubyracer>, [">= 0.11.1"])
    else
      s.add_dependency(%q<railties>, [">= 3.1"])
      s.add_dependency(%q<less-rails>, [">= 2.3"])
      s.add_dependency(%q<execjs>, [">= 1.4.0"])
      s.add_dependency(%q<rails>, [">= 3.1"])
      s.add_dependency(%q<therubyracer>, [">= 0.11.1"])
    end
  else
    s.add_dependency(%q<railties>, [">= 3.1"])
    s.add_dependency(%q<less-rails>, [">= 2.3"])
    s.add_dependency(%q<execjs>, [">= 1.4.0"])
    s.add_dependency(%q<rails>, [">= 3.1"])
    s.add_dependency(%q<therubyracer>, [">= 0.11.1"])
  end
end
