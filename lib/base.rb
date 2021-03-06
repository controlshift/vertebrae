# frozen_string_literal: true

module Vertebrae
  module Base
    def logger
      @@logger ||= Logger.new(STDOUT)
    end

    def logger=(logger)
      @@logger = logger
    end

    class << self
      def logger
        @@logger ||= Logger.new(STDOUT)
      end

      def logger=(logger)
        @@logger = logger
      end
    end

    # implement this in your api
    #
    def new(_options = {}, &_block)
      raise "implement me!"
    end

    def method_missing(method, *args, &block)
      return super unless new.respond_to?(method)
      new.send(method, *args, &block)
    end

    def respond_to?(method, include_private = false)
      # Avoid infinite loop error when attempting to stub the `new` method
      return true if method.to_s == 'new'

      new.respond_to?(method, include_private) || super(method, include_private)
    end
  end
end
