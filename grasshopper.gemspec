# frozen_string_literal: true

Gem::Specification.new do |gem|
  gem.name = 'grasshopper'
  gem.version = '1.1.1'
  gem.required_ruby_version = '>= 3.0'
  gem.license = 'LGPL-3.0'
  gem.summary = 'A tiny mocking framework focused on the Arrange-Act-Assert test pattern'
  gem.description = 'A tiny mocking framework focused on the Arrange-Act-Assert test pattern. Grasshopper is heavily modeled after Mockito.'
  gem.homepage = 'https://github.com/mattraibert/grasshopper'
  gem.author = 'Matt J Raibert'
  gem.email = 'mattraibert@positiondev.com'
  gem.files = ['Rakefile', 'README.md', 'LICENSE.txt']
  gem.files += Dir['lib/**/*']
  gem.test_files = Dir['test/**/*']
  gem.add_development_dependency('minitest', ['>= 5.19'])
  gem.add_development_dependency('minitest-reporters', ['>= 1.6'])
  gem.add_development_dependency('rake', ['>= 13.0'])
  gem.add_development_dependency('rubocop', ['>= 1.52'])
end
