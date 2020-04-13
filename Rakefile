require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

task :default => :spec

task :env do 
    require_relative './lib/pokemon_pandemic'
end  

task :console => :env do 
    binding.pry
end