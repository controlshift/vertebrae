require 'constants'
require 'configuration'
require 'connection'
require 'authorization'
require 'api'


require 'active_support/all'
require 'vertebrae/railties' if defined? Rails


module Vertebrae
  extend Configuration


  def logger
    @@logger ||= Logger.new(STDOUT)
  end

  def logger=(logger)
    @@logger = logger
  end

  # implement this in your api
  #
  def new(options = {}, &block)
    raise "implement me!"
  end

  def method_missing(method, *args, &block)
    return super unless new.respond_to?(method)
    new.send(method, *args, &block)
  end

  def respond_to?(method, include_private = false)
    new.respond_to?(method, include_private) || super(method, include_private)
  end


end