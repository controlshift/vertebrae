$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'rspec'
require 'vertebrae'
require 'dummy/dummy'
require 'dummy/client'
require 'webmock/rspec'

require 'rspec/its'

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].sort.each {|f| require f}

RSpec.configure do |config|
  config.mock_with :rspec do |mocks|
    mocks.syntax = [:should, :expect]
  end

  config.expect_with :rspec do |c|
    c.syntax = [:should, :expect]
  end
end


def reset_authentication_for(object)
  %w[username password].each do |item|
    Vertebrae::Base.send("#{item}=", nil)
    object.send("#{item}=", nil)
  end
end
