module Dummy
  extend Vertebrae::Base
  class << self
    def new(options = {}, &block)
      Dummy::Client.new(options, &block)
    end
  end
end