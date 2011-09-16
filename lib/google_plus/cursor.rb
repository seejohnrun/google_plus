require 'json'

module GooglePlus

  class Cursor

    extend GooglePlus::Resource

    def items
      @items ||= load_page(true)
    end

    def next_page
      @items = load_page
    end

    def initialize(klass, method, resource, params)
      @resource_klass = klass
      @method = method
      @resource = resource
      @base_params = params
    end

    private

    # Load the next page
    def load_page(force = false)
      if @next_page_token || force
        ap = { :pageToken => @next_page_token }
        json = self.class.make_request @method, @resource, @base_params.merge(ap)
        if json
          data = JSON::parse(json)
          @next_page_token = data['nextPageToken']
          data['items'].map { |d| @resource_klass.send(:new, d) }
        end
      end
    end

  end

end
