module Vertebrae
  class Railties < ::Rails::Railtie
    initializer 'Rails logger' do
      Vertebrae.logger = Rails.logger
    end
  end
end