require 'rubygems'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new do |task|
  task.rspec_opts = ["-c", "-f progress", "-r ./spec/spec_helper.rb"]
  task.pattern    = 'spec/**/*_spec.rb'
end

task :test do
  ENV['RACK_ENV'] = 'test'
  Rake::Task["db:setup"].invoke
  Rake::Task["spec"].invoke
end
