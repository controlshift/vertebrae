module Dummy
  extend Vertebrae
  class << self
    def new(options = {}, &block)
      Dummy::Client.new(options, &block)
    end
  end
end