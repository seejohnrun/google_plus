module GooglePlus

  module Entity

    def method_missing(method, *arguments, &block)
      method_s = method.to_s
      if @attributes.has_key?(method_s)
        val = @attributes[method_s]
        if val.is_a?(Hash)
          GooglePlus::EntityHash.new @attributes[method_s]
        else
          val
        end
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

    attr_reader :attributes

    private

    def load_hash(hash)
      # underscore all of the attributes
      @attributes = hash
      @attributes.keys.each do |key|
        mod_key = key.gsub(/::/, '/').gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').gsub(/([a-z\d])([A-Z])/,'\1_\2').tr('-', '_').downcase
        @attributes[mod_key] = @attributes.delete(key) unless mod_key == key
      end
    end

  end

  class EntityHash

    include Entity

    def initialize(hash = {})
      load_hash(hash)
    end

  end

end
