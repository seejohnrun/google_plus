module GooglePlus

  # A mixin that allows retrieval of nested attributes
  module Entity

    def self.included(base)
      base.instance_eval do
        undef_method :id if method_defined? :id
      end
    end

    # Access an attribute of the Entity
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

    # Determine if an attribute is set on the Entity
    def respond_to?(method, include_private = false)
      method_s = method.to_s
      if @attributes.has_key?(method_s)
        true
      else
        super
      end
    end

    # The raw accessible attributes
    attr_reader :attributes

    private

    # Load the data from the hash into the Entity
    def load_hash(hash)
      # underscore all of the attributes
      @attributes = hash
      @attributes.keys.each do |key|
        mod_key = key.gsub(/::/, '/').gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').gsub(/([a-z\d])([A-Z])/,'\1_\2').tr('-', '_').downcase
        @attributes[mod_key] = @attributes.delete(key) unless mod_key == key
      end
    end

  end

  # A convenience class for wrapping nestings of Entity objects so that
  # they can be traversed as deeply as desired
  class EntityHash

    include Entity

    # Initialize a new EntityHash with the given data
    def initialize(hash = {})
      load_hash(hash)
    end

  end

end
