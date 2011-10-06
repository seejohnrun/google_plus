module GooglePlus

  class ConnectionError < Exception

    # Initialize a new ConnectionError
    # @param [Exception] e The exception that occurred
    def initialize(e)
      @exception = e
    end

    # Get the message for this error
    # @return [String] a message representing this error
    def message
      @exception.message
    end

  end

end
