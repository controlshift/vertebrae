require 'faraday'
require 'faraday_middleware'
require 'request/basic_auth'
require 'response/raise_error'

module Vertebrae
  module Connection

    extend self
    include Vertebrae::Constants

    ALLOWED_OPTIONS = [
        :headers,
        :url,
        :params,
        :request,
        :ssl
    ].freeze

    def default_options(options={})
      Vertebrae::Base.faraday_options(options)
    end

    # Default middleware stack that uses default adapter as specified at
    # configuration stage.
    #
    def default_middleware(options={})
      Proc.new do |builder|
        builder.use Faraday::Request::Multipart
        builder.use Faraday::Request::UrlEncoded
        builder.use Vertebrae::Request::BasicAuth, authentication if authenticated?

        builder.use Faraday::Response::Logger if ENV['DEBUG']
        unless options[:raw]
          builder.use FaradayMiddleware::Mashify
          builder.use FaradayMiddleware::ParseJson
        end
        builder.use Vertebrae::Response::RaiseError
        builder.adapter adapter
      end
    end

    @connection = nil

    @stack = nil

    def clear_cache
      @connection = nil
    end

    def caching?
      !@connection.nil?
    end

    # Exposes middleware builder to facilitate custom stacks and easy
    # addition of new extensions such as cache adapter.
    #
    def stack(options={}, &block)
      @stack ||= begin
        if block_given?
          Faraday::Builder.new(&block)
        else
          Faraday::Builder.new(&default_middleware(options))
        end
      end
    end

    # Returns a Fraday::Connection object
    #
    def connection(options={})
      conn_options = default_options(options)
      clear_cache unless options.empty?
      Vertebrae::Base.logger.debug "OPTIONS:#{conn_options.inspect}"

      @connection ||= Faraday.new(conn_options.merge(:builder => stack(options)))
    end


  end
end