# frozen_string_literal: true

require 'faraday'
require 'faraday/multipart'
require 'faraday/mashify'
require 'vertebrae/response/raise_error'
require 'vertebrae/authorization'

module Vertebrae
  class Connection
    include Vertebrae::Constants
    include Vertebrae::Authorization

    attr_reader :options
    attr_accessor :configuration
    attr_accessor :faraday_connection

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

    # Returns a Faraday::Connection object
    #
    def connection
      self.faraday_connection ||= Faraday.new(configuration.faraday_options) do |f|
        if configuration.authenticated?
          f.request :authorization, :basic, configuration.username, configuration.password
        end
        f.request :multipart
        f.request :url_encoded
        unless options[:raw]
          f.response :mashify
          f.response :json
        end

        f.response :raise_error
        f.adapter configuration.adapter
      end
    end
  end
end
