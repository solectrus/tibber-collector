require 'rubygems'
require 'bundler'
require 'rake/testtask'
require 'dotenv'
Dotenv.load('.env.test')

Rake::TestTask.new :test do |t|
  t.libs << 'test' << 'app'
  t.test_files = FileList['test/**/*_test.rb']
  t.verbose = true
end

task default: :test

desc 'Get schema from Tibber and save it to schema.json'
task :dump_schema do
  require './app/tibber'
  require './app/config'

  config = Config.from_env

  Tibber.new(config:).dump_schema
end
