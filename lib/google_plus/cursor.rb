require 'json'

module GooglePlus

  class Cursor

    extend GooglePlus::Resource

    def items(params = {})
      if instance_variable_defined?(:@items)
        # TODO raise error if params are passed here, since they're meaningless
        @items
      else
        @items = load_page(true, params)
      end
    end

    def next_page(params = {})
      @items = load_page(false, params)
    end

    def initialize(klass, method, resource, params)
      @resource_klass = klass
      @method = method
      @resource = resource
      @base_params = params
    end

    private

    # Load the next page
    def load_page(force = false, params)
      if @next_page_token || force
        ap = params.merge(@base_params)
        ap[:maxResults] = ap.delete(:max_results) if ap.has_key?(:max_results)
        ap[:fields] = ap.delete(:fields) if ap.has_key?(:fields)
        ap[:pageToken] = @next_page_token if @next_page_token
        # make request
        if json = self.class.make_request(@method, @resource, ap)
          data = JSON::parse(json)
          @next_page_token = data['nextPageToken']
          if items = data['items']
            return data['items'].map { |d| @resource_klass.send(:new, d) }
          end
        end
      end
      # otherwise, nil
      nil
    end

  end

end
