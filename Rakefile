begin
  require 'rspec/core/rake_task'

  RSpec::Core::RakeTask.new(:spec)
  task :default => :spec
rescue LoadError
  puts "RSpec is unavailable. Please run 'bundle install' and try again."
end