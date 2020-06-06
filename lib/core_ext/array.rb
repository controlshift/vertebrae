# frozen_string_literal: true

class Array
  def extract_options!
    last.is_a?(::Hash) ? pop : {}
  end
end