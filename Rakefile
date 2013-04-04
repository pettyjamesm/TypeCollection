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
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "typecollection"
  gem.homepage = "http://github.com/pettyjamesm/TypeCollection"
  gem.license = "MIT"
  gem.summary = %Q{TypeCollection maintains a record of sub-types for a given
    class based on a common suffix.}
  gem.description = %Q{Easily map subtypes into their parent type for later retrieval}
  gem.email = "jp@jibe.com"
  gem.authors = ["James Petty"]
  # dependencies defined in Gemfile
end
Jeweler::RubygemsDotOrgTasks.new

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

task :default => :test

