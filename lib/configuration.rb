module Vertebrae
  class Configuration
    include Vertebrae::Constants
    include ActiveSupport::Inflector
    include Authorization

    VALID_OPTIONS_KEYS = [
        :adapter,
        :prefix,
        :ssl,
        :mime_type,
        :user_agent,
        :host,
        :username,
        :password,
        :connection_options,
        :content_type,
        :scheme,
    ].freeze

    # Other adapters are :typhoeus, :patron, :em_synchrony, :excon, :test
    DEFAULT_ADAPTER = :net_http

    # The default HTTP scheme configuration
    DEFAULT_SCHEME = 'https'

    # The default SSL configuration
    DEFAULT_SSL = {}

    # By default the <tt>Accept</tt> header will make a request for <tt>JSON</tt>
    DEFAULT_MIME_TYPE = :json

    # The value sent in the http header for 'User-Agent' if none is set
    DEFAULT_USER_AGENT = "Vertebrae REST Gem".freeze

    # by default do not set a host. this is specific to AK instance
    DEFAULT_HOST = nil

    # The api endpoint used to connect to AK if none is set
    DEFAULT_PREFIX = '/'.freeze

    # By default, don't set a user ame
    DEFAULT_USERNAME = nil

    # By default, don't set a user password
    DEFAULT_PASSWORD = nil

    # By default uses the Faraday connection options if none is set
    DEFAULT_CONNECTION_OPTIONS = {}

    DEFAULT_CONTENT_TYPE = 'application/json'.freeze


    VALID_OPTIONS_KEYS.each do | key |
      define_method("default_#{key}".intern) { default_options[key] }
    end

    VALID_OPTIONS_KEYS.each do | key |
      define_method(key) do
        options[key] || self.send("default_#{key}")
      end
    end

    VALID_OPTIONS_KEYS.each do | key |
      define_method("#{key}=".intern) do |value|
        options[key] = value
      end
    end

    attr_accessor :options
    attr_accessor :default_options

    def initialize(options)
      self.options = options
      self.default_options = {}

      VALID_OPTIONS_KEYS.each do |key|
        default_options[key] = "Vertebrae::Configuration::DEFAULT_#{key.to_s.upcase}".constantize
      end
    end


    def faraday_options
      {
        :headers => {
          ACCEPT           => "application/json;q=0.1",
          ACCEPT_CHARSET   => "utf-8",
          USER_AGENT       => user_agent,
          CONTENT_TYPE     => content_type
        },
        :ssl =>  ssl,
        :url => endpoint
      }
    end


    # Extract login and password from basic_auth parameter
    #
    def process_basic_auth(auth)
      case auth
        when String
          self.username, self.password = auth.split(':', 2)
        when Hash
          self.username = auth[:username]
          self.password = auth[:password]
      end
    end


    def endpoint
      "#{self.scheme}://#{self.host}#{self.prefix}"
    end
  end
end