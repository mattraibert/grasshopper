# encoding: utf-8

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  gem.name = "grasshopper"
  gem.summary = 'A tiny mocking framework focused on the Arrange-Act-Assert test pattern'
  gem.description = "A tiny mocking framework focused on the Arrage-Act-Assert test pattern. Grasshopper is heavily modeled after Mockito."
  gem.version = '0.4.2'
  gem.homepage = "http://github.com/mattraibert/grasshopper"
  gem.email = "mattraibert@gmail.com"
  gem.authors = ["Matt J Raibert"]
  gem.license = "GPLv3"
  gem.files = Dir['lib/**/*']
  gem.test_files = Dir["test/**/*"]
  gem.require_path = 'lib'
end
Jeweler::RubygemsDotOrgTasks.new

require 'rake/testtask'
Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = FileList['test/**/*_test.rb']
  t.verbose = true
end

task :default => :test
