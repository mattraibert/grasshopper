# encoding: utf-8

Gem::Specification.new do |gem|
  gem.name = "grasshopper"
  gem.version = '1.1.1'
  gem.license = "LGPL-3.0"
  gem.summary = 'A tiny mocking framework focused on the Arrange-Act-Assert test pattern'
  gem.description = "A tiny mocking framework focused on the Arrange-Act-Assert test pattern. Grasshopper is heavily modeled after Mockito."
  gem.homepage = "http://github.com/mattraibert/grasshopper"
  gem.author = "Matt J Raibert"
  gem.email = "mattraibert@positiondev.com"
  gem.files = ["Rakefile", "README.md", "LICENSE.txt"]
  gem.files += Dir['lib/**/*']
  gem.test_files = Dir["test/**/*"]
end
