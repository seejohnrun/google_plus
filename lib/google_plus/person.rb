require 'json'
require File.dirname(__FILE__) + '/entity'

module GooglePlus

  class Person

    extend GooglePlus::Resource
    include GooglePlus::Entity

    def self.get(user_id, params = {})
      data = make_request(:get, "people/#{user_id}", params)
      Person.new(JSON.parse(data)) if data
    end

    def self.search(query, params = {})
      params[:query] = URI.escape(query)
      resource = 'people'
      GooglePlus::Cursor.new(self, :get, resource, params)
    end

    # get a cursor for activities for this user
    def list_activities
      GooglePlus::Activity.for_person(id)
    end

    def initialize(hash)
      load_hash(hash)
    end

  end

end
