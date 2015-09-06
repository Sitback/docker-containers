require 'rake'
require 'rspec/core/rake_task'

# task :spec => 'spec:all'
task :build => 'docker:build'
task :ci_build => 'docker:ci_build'
task :test => 'docker:test'
task :publish => 'docker:publish'
task :default => 'docker:build_and_test'

namespace :docker do
  task :build_and_test => [:build, :test]
  task :default => :build_and_test

  desc "Build all containers within a CI environment"
  task :build do
    require_relative '_scripts/travis-build.rb'
  end

  desc "Build all containers"
  task :build do
    require_relative '_scripts/build.rb'
  end

  test_targets = []
  Dir.glob('./spec/*').each do |dir|
    next unless File.directory?(dir)
    target = File.basename(dir)
    next if target.start_with? '_'
    target = "_#{target}" if target == "default"
    test_targets << target
  end

  desc "Run tests for all containers"
  task "test:all" => test_targets

  test_targets.each do |target|
    original_target = target == "_default" ? target[1..-1] : target
    desc "Run serverspec tests to #{target}"
    task "test:#{target}"
    RSpec::Core::RakeTask.new(target.to_sym) do |t|
      t.pattern = "spec/#{target}/*_spec.rb"
    end
  end

  desc "Publish all containers"
  task :publish do
    require_relative '_scripts/publish.rb'
  end
end
