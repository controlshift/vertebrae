# frozen_string_literal: true

module Vertebrae
  class Configuration
    include Vertebrae::Constants
    include ActiveSupport::Inflector
    include Authorization

    VALID_OPTIONS_KEYS = [
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
        :port,
        :additional_headers
    ].freeze

    # The default HTTP scheme configuration
    DEFAULT_SCHEME = 'https'

    # The default SSL configuration
    DEFAULT_SSL = {}

    # by default do not set a port so that it is not specified on endpoint
    DEFAULT_PORT = nil

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
    DEFAULT_ADDITIONAL_HEADERS = {}.freeze

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

    def adapter
      options[:adapter] || auto_detect_adapter
    end

    def adapter=(value)
      options[:adapter] = value
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
        }.merge(additional_headers),
        :ssl => ssl,
        :url => endpoint
      }.merge(connection_options)
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
      "#{self.scheme}://#{self.host}#{self.port.present? ? ":#{self.port}" : ''}#{self.prefix}"
    end

    private

    # Auto-detect the best adapter (HTTP "driver") available, based on libraries
    # loaded by the user, preferring those with persistent connections
    # ("keep-alive") by default
    #
    # @return [Symbol]
    #
    #
    def auto_detect_adapter
      case
        when defined?(::Typhoeus)
          :typhoeus
        when defined?(::Patron)
          :patron
        when defined?(::HTTPClient)
          :httpclient
        when defined?(::Net::HTTP::Persistent)
          :net_http_persistent
        else
          ::Faraday.default_adapter
      end
    end
  end
end
