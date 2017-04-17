# encoding: utf-8

Gem::Specification.new do |gem|
  gem.name = "grasshopper"
  gem.version = '1.1.0'
  gem.license = "LGPL-3.0"
  gem.summary = 'A tiny mocking framework focused on the Arrange-Act-Assert test pattern'
  gem.description = "A tiny mocking framework focused on the Arrage-Act-Assert test pattern. Grasshopper is heavily modeled after Mockito."
  gem.homepage = "http://github.com/mattraibert/grasshopper"
  gem.author = "Matt J Raibert"
  gem.email = "mattraibert@positiondev.com"
  gem.files = ["Rakefile", "README.md", "LICENSE.txt"]
  gem.files += Dir['lib/**/*']
  gem.test_files = Dir["test/**/*"]
  gem.add_development_dependency(%q<minitest>, [">= 0"])
  gem.add_development_dependency(%q<minitest-reporters>, [">= 0.5.0"])
  gem.add_development_dependency(%q<bundler>, [">= 0"])
  gem.add_development_dependency(%q<posto>, [">= 0"])
  gem.add_development_dependency(%q<pry>, [">= 0"])
end
