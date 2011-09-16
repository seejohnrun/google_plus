module GooglePlus

  class ConnectionError < Exception

    def initialize(e)
      @exception = e
    end

    def message
      @exception.message
    end

  end

end
