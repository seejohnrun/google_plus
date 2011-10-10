require 'json'
require File.dirname(__FILE__) + '/../entity'

module GooglePlus

  # An error class for wrapping errors made during requests, and making its attributes
  # available similar to any [GooglePlus::Entity]
  class RequestError < Exception

    include GooglePlus::Entity

    # Instantiate a new GooglePlus::RequestError and allow it to be accessed
    # as an entity
    # @param [Exception] e The original exception
    def initialize(e)
      load_hash JSON.parse(e.response.body)
    end

  end

end
