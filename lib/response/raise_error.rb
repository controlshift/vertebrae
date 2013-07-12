module Vertebrae
  module Response
    class RaiseError < Faraday::Response::Middleware

      def on_complete(response)
        status_code = response[:status].to_i
        if (500...600).include? status_code
          raise Exception.new(error_message(response))
        end
      end

      def error_message(response)
        "#{response[:method].to_s.upcase} #{response[:url].to_s}: #{response[:status]} \n\n #{response[:body] if response[:body]}"
      end
    end

    class NotFound < Exception ; end
  end # Response::RaiseError
end