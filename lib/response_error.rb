module Vertebrae
  class ResponseError < StandardError
    attr_reader :status_code

    def initialize(status_code, response)
      @status_code = status_code
      super(error_message(response))
    end

    private

    def error_message(response)
      "#{response[:method].to_s.upcase} #{response[:url].to_s}: #{response[:status]} \n\n #{response[:body] if response[:body]}"
    end
  end
end