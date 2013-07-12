$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'rspec'
require 'vertebrae'

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

RSpec.configure do |config|
  
end


def reset_authentication_for(object)
  [ 'username', 'password' ].each do |item|
    Vertebrae.send("#{item}=", nil)
    object.send("#{item}=", nil)
  end
end
