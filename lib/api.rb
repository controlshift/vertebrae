module Vertebrae
  class API
    include Request

    attr_accessor :connection

    # Create new API
    #
    def initialize(options={}, &block)
      options.merge!(default_options)

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

    def request(method, path, params, options) # :nodoc:
      if !::Vertebrae::Request::METHODS.include?(method)
        raise ArgumentError, "unknown http method: #{method}"
      end

      path =  connection.configuration.prefix + '/' + path

      ::Vertebrae::Base.logger.debug "EXECUTED: #{method} - #{path} with #{params} and #{options}"

      connection.connection.send(method) do |request|

        case method.to_sym
          when *(::Vertebrae::Request::METHODS - ::Vertebrae::Request::METHODS_WITH_BODIES)
            request.body = params.delete('data') if params.has_key?('data')
            request.url(path, params)
          when *::Vertebrae::Request::METHODS_WITH_BODIES
            request.path = path
            request.body = extract_data_from_params(params) unless params.empty?
        end
      end
    end


    def yield_or_eval(&block)
      return unless block
      block.arity > 0 ? yield(self) : self.instance_eval(&block)
    end

  end
end