# frozen_string_literal: true

require 'active_support/all'

require 'vertebrae/constants'
require 'vertebrae/authorization'
require 'vertebrae/configuration'
require 'vertebrae/connection'
require 'vertebrae/request'
require 'vertebrae/response_error'
require 'vertebrae/api'
require 'vertebrae/base'
require 'vertebrae/model'
require 'vertebrae/version'

require 'vertebrae/railties' if defined? Rails

module Vertebrae

end
