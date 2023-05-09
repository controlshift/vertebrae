# frozen_string_literal: true

require 'faraday/response'

module Vertebrae
  module Response
    class RaiseError < Faraday::Middleware

      def on_complete(response)
        status_code = response[:status].to_i
        if (400...600).include? status_code
          raise ResponseError.new(status_code, response)
        end
      end
    end
  end # Response::RaiseError
end
