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
  gem.summary = 'A tiny mocking framework based on Mockito'
  gem.description = 'A tiny mocking framework based on Mockito'
  gem.version = '0.2.0'
  gem.homepage = "http://github.com/mattraibert/grasshopper"
  gem.email = "mattraibert@gmail.com"
  gem.authors = ["Matt Raibert"]
  gem.license = "GPL"

  gem.required_rubygems_version = ">= 1.3.6"
  gem.files = Dir['lib/**/*']
  gem.rubyforge_project = 'nowarning'
  gem.require_path = 'lib'
end
Jeweler::RubygemsDotOrgTasks.new

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/*_test.rb'
  test.verbose = true
end

task :default => :test
