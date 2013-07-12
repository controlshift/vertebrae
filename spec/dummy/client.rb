module Dummy
  class Client < Vertebrae::API
    def api(options={}, &block)
      @api ||= Vertebrae::API.new(current_options.merge(options), &block)
    end
  end
end