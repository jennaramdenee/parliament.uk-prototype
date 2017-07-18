# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
# Prevent database truncation if the environment is production
abort('The Rails environment is running in production mode!') if Rails.env.production?
require 'spec_helper'
require 'rspec/rails'
require 'capybara/rails'
require 'vcr'

require 'parliament'
require 'parliament/utils'

# Add additional requires below this line. Rails is not loaded until this point!

Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

RSpec.configure do |config|

  # RSpec Rails can automatically mix in different behaviours to your tests
  # based on their file location, for example enabling you to call `get` and
  # `post` in specs under `spec/controllers`.
  #
  # You can disable this behaviour by removing the line below, and instead
  # explicitly tag your specs with their type, e.g.:
  #
  #     RSpec.describe UsersController, :type => :controller do
  #       # ...
  #     end
  #
  # The different available types are documented in the features, such as in
  # https://relishapp.com/rspec/rspec-rails/docs
  config.infer_spec_type_from_file_location!

  # Filter lines from Rails gems in backtraces.
  config.filter_rails_from_backtrace!
  # arbitrary gems may also be filtered via:
  # config.filter_gems_from_backtrace("gem name")
  config.include Parliament::Utils::Helpers::ApplicationHelper

  # Set Parliament::Utils::Helpers::HousesHelper#set_ids instance variables to nil after each spec.
  # Calling certain Parliament::Utils::Helpers::HousesHelper methods (e.g. Parliament::Utils::Helpers::HousesHelper#commons?) causes
  # Parliament::Utils::Helpers::HousesHelper#set_ids to be called which sets @commons_id and @lords_id.
  # Setting these to nil causes each spec that requires them to make another
  # Parliament::Utils::Helpers::ParliamentHelper request and generate a VCR cassette and stops any RSpec
  # ordering issues where they may or may not have been set by the previous spec.
  config.after(:each) do
    Parliament::Utils::Helpers::HousesHelper.instance_variable_set(:@commons_id, nil)
    Parliament::Utils::Helpers::HousesHelper.instance_variable_set(:@lords_id, nil)
  end

  #Stubs Bandiera::Client methods enabled? and get_features_for_group to clean up logs
  #and streamline cassette
  # Parliament::Utils::TestHelpers.included_modules.each do |m|
  #   m.load_rspec_config(config)
  # end
  config.before(:each) do
    allow(BANDIERA_CLIENT).to receive(:enabled?).and_return(false)
    allow(Pugin::BANDIERA_CLIENT).to receive(:get_features_for_group).and_return({})
  end
end

def session
  last_request.env['rack.session']
end
