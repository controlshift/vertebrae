# frozen_string_literal: true

module Vertebrae
  class Model
    attr_accessor :client

    def initialize(attrs = {})
      attrs.each do |key,value|
        if self.respond_to?("#{key}=")
          self.send("#{key}=", value)
        end
      end
    end
  end
end