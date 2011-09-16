require 'json'
require File.dirname(__FILE__) + '/../entity'

module GooglePlus

  class RequestError < Exception

    include GooglePlus::Entity

    def initialize(e)
      load_hash JSON.parse(e.response.body)
    end

  end

end
