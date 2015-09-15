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
    spec_parts = file.match('\.\/spec\/(.+)\/(.+)_spec\.rb')
    test_name = "test:#{spec_parts[1]}:#{spec_parts[2]}"

    desc "Run tests from spec in '#{file}'"
    RSpec::Core::RakeTask.new(test_name, :ci) do |t, task_args|
      t.pattern = file
      if task_args[:ci]
        if ENV['CIRCLE_TEST_REPORTS']
          report_dir = ENV['CIRCLE_TEST_REPORTS'].to_s
        else
          report_dir = '.'
        end
        t.rspec_opts = "--format RspecJunitFormatter --out #{report_dir}/rspec.xml"
      end
    end

    tests << test_name
  end

  desc "Run all tests."
  task "test:all" => tests

  desc "Run tests in parallel on CircleCI"
  task "test:_circleci_parallel" do
    if ENV['CIRCLECI']
      i = 0
      total_nodes = ENV['CIRCLE_NODE_TOTAL'].to_i
      node_index = ENV['CIRCLE_NODE_INDEX'].to_i

      tests.each do |test|
        if ((i % total_nodes) == node_index)
          system! "bundle exec rake docker:#{test}[ci]"
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

  def system! (cmd, ignore_exit = false)
    system(cmd)

    # Non-zero exit on failure.
    exit $?.exitstatus unless $?.success? or ignore_exit
  end
end
