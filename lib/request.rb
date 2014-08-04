module Vertebrae
  module Request

    METHODS = [:get, :post, :put, :delete, :patch]
    METHODS_WITH_BODIES = [ :post, :put, :patch ]

    def get_request(path, params={}, options={})
      request(:get, path, params, options)
    end

    def patch_request(path, params={}, options={})
      request(:patch, path, params, options)
    end

    def post_request(path, params={}, options={})
      request(:post, path, params, options)
    end

    def put_request(path, params={}, options={})
      request(:put, path, params, options)
    end

    def delete_request(path, params={}, options={})
      request(:delete, path, params, options)
    end

    def request(method, path, params, options) # :nodoc:
      if !::Vertebrae::Request::METHODS.include?(method)
        raise ArgumentError, "unknown http method: #{method}"
      end
      connection.options = default_options.merge(initialisation_options.merge(options))

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
  end
end