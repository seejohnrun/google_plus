module GooglePlus

  # A class for easily paginating through lists of Google Plus
  # results.  Automatically handles details like nextPageToken
  class Cursor

    extend GooglePlus::Resource

    # Go through each item
    # @yieldparam [GooglePlus::Entity] an individual item
    # @yieldreturn [GooglePlus::Cursor] self
    def each
      while items = next_page({:max_results => 100})
        break if items.empty?
        items.each do |item|
          yield item
        end
      end
      self
    end

    # Get the current page of results
    # @return [Array] the current page of results, or nil if the page is blank
    def items(params = {})
      if instance_variable_defined?(:@items)
        # TODO raise error if params are passed here, since they're meaningless
        @items
      else
        @items = load_page(params)
      end
    end

    # Load the next page of results and load it as the current page
    # @return [Array] the next page of results, or nil if the page is blank
    def next_page(params = {})
      @items = load_page(params)
    end

    # Create a new cursor
    # @param [Class] klass - The class type to instantiate members of this cursor as
    # @param [Symbol] method - The HTTP method if this request
    # @param [String] resource - The path of this request relative to the API
    # @param [Hash] params - a set of parameters to be merged into the request
    def initialize(klass, method, resource, params = {})
      @first_page_loaded = false
      @resource_klass = klass
      @method = method
      @resource = resource
      @base_params = params
    end

    private

    # Load the next page
    def load_page(params)
      if @next_page_token || !@first_page_loaded
        @first_page_loaded = true
        ap = params.merge(@base_params)
        ap[:maxResults] = ap.delete(:max_results) if ap.has_key?(:max_results)
        ap[:fields] = ap.delete(:fields) if ap.has_key?(:fields)
        ap[:pageToken] = @next_page_token if @next_page_token
        # make request
        if json = self.class.make_request(@method, @resource, ap)
          data = JSON::parse(json)
          @next_page_token = data['nextPageToken']
          if items = data['items']
            return nil if items.empty?
            return items.map { |d| @resource_klass.send(:new, d) }
          end
        end
      end
      # otherwise, nil
      nil
    end

  end

end
