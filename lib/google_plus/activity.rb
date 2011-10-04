require 'json'
require File.dirname(__FILE__) + '/entity'

module GooglePlus

  class Activity

    extend GooglePlus::Resource
    include GooglePlus::Entity

    def self.get(activity_id)
      data = make_request(:get, "activities/#{activity_id}")
      Activity.new(JSON.parse(data)) if data
    end

    def self.for_person(user_id, params = {})
      collection = params[:collection] || :public
      resource = "people/#{user_id}/activities/#{collection}"
      GooglePlus::Cursor.new(self, :get, resource, params)
    end

    def list_comments
      GooglePlus::Comment.for_activity(id) 
    end

    def person
      @person ||= GooglePlus::Person.get(actor.id)
    end

    def initialize(hash)
      load_hash(hash)
    end

  end

end
