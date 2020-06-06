# frozen_string_literal: true

module Vertebrae
  module Authorization
    def username?
      username.present?
    end

    def password?
      password.present?
    end

    # Check whether authentication credentials are present
    def authenticated?
      (username? && password?)
    end

    def basic_auth
      "#{username}:#{password}"
    end

    def authentication
      { :basic_auth => basic_auth }
    end
  end # Authorization
end