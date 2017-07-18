require 'parliament/utils/test_helpers'

# Load RSpec configurations held within all test helper modules included in the
# overarching Parliament::Utils::TestHelpers module
RSpec.configure do |config|
  Parliament::Utils::TestHelpers.included_modules.each do |m|
    m.load_rspec_config(config)
  end

end
