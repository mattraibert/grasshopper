# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "grasshopper"
  s.version = "0.2.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.3.6") if s.respond_to? :required_rubygems_version=
  s.authors = ["Matt Raibert"]
  s.date = "2012-09-01"
  s.description = "A tiny mocking framework based on Mockito"
  s.email = "mattraibert@gmail.com"
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.md"
  ]
  s.files = [
    "lib/grasshopper.rb"
  ]
  s.homepage = "http://github.com/mattraibert/grasshopper"
  s.licenses = ["GPL"]
  s.require_paths = ["lib"]
  s.rubyforge_project = "nowarning"
  s.rubygems_version = "1.8.24"
  s.summary = "A tiny mocking framework based on Mockito"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<minitest>, [">= 0"])
      s.add_development_dependency(%q<minitest-reporters>, [">= 0.5.0"])
      s.add_development_dependency(%q<bundler>, [">= 0"])
      s.add_development_dependency(%q<jeweler>, [">= 0"])
    else
      s.add_dependency(%q<minitest>, [">= 0"])
      s.add_dependency(%q<minitest-reporters>, [">= 0.5.0"])
      s.add_dependency(%q<bundler>, [">= 0"])
      s.add_dependency(%q<jeweler>, [">= 0"])
    end
  else
    s.add_dependency(%q<minitest>, [">= 0"])
    s.add_dependency(%q<minitest-reporters>, [">= 0.5.0"])
    s.add_dependency(%q<bundler>, [">= 0"])
    s.add_dependency(%q<jeweler>, [">= 0"])
  end
end

