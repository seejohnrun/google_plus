require 'json'
require File.dirname(__FILE__) + '/entity'

module GooglePlus

  class Activity

    extend GooglePlus::Resource
    include GooglePlus::Entity

    def self.get(activity_id, params = {})
      data = make_request(:get, "activities/#{activity_id}", params)
      Activity.new(JSON.parse(data)) if data
    end

    def self.search(query, params = {})
      params[:query] = URI.escape(query)
      params[:orderBy] = params.delete(:order_by) if params.has_key?(:order_by)
      resource = 'activities'
      GooglePlus::Cursor.new(self, :get, resource, params)
    end

    def self.for_person(user_id, params = {})
      collection = params[:collection] || :public
      resource = "people/#{user_id}/activities/#{collection}"
      GooglePlus::Cursor.new(self, :get, resource, params)
    end

    # get the comments for this activity
    def list_comments
      GooglePlus::Comment.for_activity(id) 
    end

    # get the actor of this activity
    def person
      @person ||= GooglePlus::Person.get(actor.id)
    end

    # list the people of a certain action on this activity
    # options available at https://developers.google.com/+/api/latest/people/listByActivity
    def list_people(collection, params = {})
      resource = "activities/#{id}/people/#{collection}"
      GooglePlus::Cursor.new(GooglePlus::Person, :get, resource, params)
    end

    # get a cursor for the plusoners of this activity
    def plusoners(params = {})
      list_people(:plusoners)
    end

    # get a cursor for the resharers of this activity
    def resharers(params = {})
      list_people(:resharers)
    end

    def initialize(hash)
      load_hash(hash)
    end

  end

end
