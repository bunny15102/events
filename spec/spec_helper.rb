# This file is intended to be required by `rails_helper.rb` before each test suite.

# Require FactoryBot for creating test data
require 'factory_bot_rails'

# Define the default RSpec configuration
RSpec.configure do |config|
  # Include FactoryBot syntax methods
  config.include FactoryBot::Syntax::Methods

  # Enable running specs in random order to surface order dependencies
  config.order = :random

  # Seed global randomization in this process using the `--seed` CLI option
  Kernel.srand(config.seed)
end

# Configure FactoryBot
RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
end
