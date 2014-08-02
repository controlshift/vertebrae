module Vertebrae
  module Response
    class RaiseError < Faraday::Response::Middleware

      def on_complete(response)
        status_code = response[:status].to_i
        if (400...600).include? status_code
          raise StandardError.new(error_message(response))
        end
      end

      def error_message(response)
        "#{response[:method].to_s.upcase} #{response[:url].to_s}: #{response[:status]} \n\n #{response[:body] if response[:body]}"
      end
    end

    class NotFound < StandardError ; end
  end # Response::RaiseError
end