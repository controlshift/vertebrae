# frozen_string_literal: true

module Vertebrae
  class Railties < ::Rails::Railtie
    initializer 'Rails logger' do
      Vertebrae::Base.logger = Rails.logger
    end
  end
end