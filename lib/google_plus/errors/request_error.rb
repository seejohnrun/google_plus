require 'json'

module GooglePlus

  class RequestError < Exception

    include GooglePlus::Entity

    def initialize(e)
      @attributes = JSON.parse(e.response.body)
      # TODO alias message
    end

  end

end
