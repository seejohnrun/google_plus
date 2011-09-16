module GooglePlus

  class Entity

    def method_missing(method, *arguments, &block)
      method_s = method.to_s
      if @attributes.has_key?(method_s)
        GooglePlus::Entity.new @attributes[method_s]
      else
        super
      end
    end

    def respond_to?(method, include_private = false)
      method_s = method.to_s
      if @attributes.has_key?(method_s)
        true
      else
        super
      end
    end

    private

    def initialize(hash)
      @attributes = hash
    end

  end

end
