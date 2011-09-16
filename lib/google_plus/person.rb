require 'json'
require File.dirname(__FILE__) + '/entity'

module GooglePlus

  class Person

    extend GooglePlus::Resource
    include GooglePlus::Entity

    def self.get(user_id)
      data = make_request(:get, "people/#{user_id}")
      Person.new(JSON.parse(data)) if data
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
