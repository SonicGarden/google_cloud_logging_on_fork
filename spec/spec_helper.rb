require 'bundler/setup'
require 'google_cloud_logging_on_fork'
require 'aruba/rspec'
require 'pry'
require 'helpers/test_application_helper'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
