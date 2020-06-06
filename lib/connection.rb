# frozen_string_literal: true

require 'faraday'
require 'faraday_middleware'
require 'response/raise_error'
require 'authorization'

module Vertebrae
  class Connection
    include Vertebrae::Constants
    include Vertebrae::Authorization

    attr_reader :options
    attr_accessor :configuration

    ALLOWED_OPTIONS = [
        :headers,
        :url,
        :params,
        :request,
        :ssl
    ].freeze

    def initialize(options)
      @options = options
      @configuration = Vertebrae::Configuration.new(options)
      @stack = nil
    end

    def options=(options)
      @options = options
      @configuration = Vertebrae::Configuration.new(options)
    end

    # Default middleware stack that uses default adapter as specified at
    # configuration stage.
    #
    def default_middleware
      Proc.new do |builder|
        builder.use Faraday::Request::Multipart
        builder.use Faraday::Request::UrlEncoded
        if configuration.authenticated?
          builder.use Faraday::Request::BasicAuthentication, configuration.username, configuration.password
        end

        builder.use Faraday::Response::Logger if ENV['DEBUG']
        unless options[:raw]
          builder.use FaradayMiddleware::Mashify
          builder.use FaradayMiddleware::ParseJson
        end
        builder.use Vertebrae::Response::RaiseError
        builder.adapter configuration.adapter
      end
    end

    # Exposes middleware builder to facilitate custom stacks and easy
    # addition of new extensions such as cache adapter.
    #
    def stack(&block)
      @stack ||= begin
        if block_given?
          Faraday::RackBuilder.new(&block)
        else
          Faraday::RackBuilder.new(&default_middleware)
        end
      end
    end

    # Returns a Faraday::Connection object
    #
    def connection
      Faraday.new(configuration.faraday_options.merge(:builder => stack))
    end
  end
end
