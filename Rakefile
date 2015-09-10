require 'rake'
require 'rspec/core/rake_task'

task :build => 'docker:build'
task :ci_build => 'docker:ci_build'
task :test => 'docker:test'
task :publish => 'docker:publish'
task :default => 'docker:build_and_test'

namespace :docker do
  task :build_and_test => [:build, :test]
  task :default => :build_and_test

  desc "Build all containers within a CI environment"
  task :ci_build do
    require_relative '_scripts/ci-build.rb'
  end

  desc "Build all containers"
  task :build do
    require_relative '_scripts/build.rb'
  end

  tests = []
  Dir.glob('./spec/**/*_spec.rb').each do |file|
    spec_name = file.match('\.\/spec\/(.+)\/(.+)_spec\.rb')[2]
    test_name = "test:#{spec_name}"

    desc "Run tests from spec in '#{file}'"
    RSpec::Core::RakeTask.new("test:#{spec_name}") do |t|
      t.pattern = file
    end

    tests << test_name
  end

  desc "Run all tests."
  task "test:all" => tests

  desc "Run tests in parallel on CircleCI"
  task "test:circleci_parallel" do
    if ENV['CIRCLECI']
      i = 0
      total_nodes = ENV['CIRCLE_NODE_TOTAL'].to_i
      node_index = ENV['CIRCLE_NODE_INDEX'].to_i
      report_dir = ENV['CIRCLE_TEST_REPORTS'].to_s
      format = "--format RspecJunitFormatter --out #{report_dir}/rspec.xml"

      tests.each do |test|
        if ((i % total_nodes) == node_index)
          system "bundle exec rake docker:#{test} #{format}"
        end
        i += 1
      end
    else
      puts "Not CircleCI, cowardly refusing to run."
    end
  end

  desc "Publish all containers"
  task :publish do
    require_relative '_scripts/publish.rb'
  end
end
