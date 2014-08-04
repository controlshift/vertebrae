module Vertebrae
  class API
    include Request

    attr_accessor :connection, :initialisation_options

    # Create new API
    #
    def initialize(options={}, &block)
      self.initialisation_options = options
      options = default_options.merge(options)

      yield_or_eval(&block) if block_given?
      self.connection = Connection.new(options)
      self.connection.configuration.process_basic_auth(options[:basic_auth])
      setup
    end

    def setup
    end

    def default_options
      {}
    end

    def yield_or_eval(&block)
      return unless block
      block.arity > 0 ? yield(self) : self.instance_eval(&block)
    end

  end
end