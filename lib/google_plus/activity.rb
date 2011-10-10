require 'json'
require File.dirname(__FILE__) + '/entity'

module GooglePlus

  # An Acitity in Google Plus
  class Activity

    extend GooglePlus::Resource
    include GooglePlus::Entity

    # Get an activity by ID
    # @param [String] activity_id The id of the activity to look up
    # @option params [Symbol] :key A different API key to use for this request
    # @option params [Symbol] :user_ip The IP of the user on who's behalf this request is made
    # @return [GooglePlus::Activity] an activity object for the activity, if it
    #   is found - otherwise, return nil
    def self.get(activity_id, params = {})
      data = make_request(:get, "activities/#{activity_id}", params)
      Activity.new(JSON.parse(data)) if data
    end

    # Search for an activity
    # @param [String] query The query string to search for
    # @option params [Symbol] :key A different API key to use for this request
    # @option params [Symbol] :user_ip The IP of the user on who's behalf this request is made
    # @return [GooglePlus::Cursor] a cursor that will paginate through the results
    #   for the activity search
    def self.search(query, params = {})
      params[:query] = URI.escape(query)
      params[:orderBy] = params.delete(:order_by) if params.has_key?(:order_by)
      resource = 'activities'
      GooglePlus::Cursor.new(self, :get, resource, params)
    end

    # Get a list of activities from this person
    # @param [String] user_id The ID of the user to look up activities for
    # @option params [Symbol] :collection What collection to pull activities for
    #   defaults to :public
    # @option params [Symbol] :key A different API key to use for this request
    # @option params [Symbol] :user_ip The IP of the user on who's behalf this request is made
    # @return [GooglePlus::Cursor] a cursor that will paginate through the results
    #   for the activity list
     def self.for_person(user_id, params = {})
      collection = params[:collection] || :public
      resource = "people/#{user_id}/activities/#{collection}"
      GooglePlus::Cursor.new(self, :get, resource, params)
    end

    # Get the list of comments for an activity
    # @return [GooglePlus::Cursor] a cursor for paginating through the comments on this activity
    def list_comments
      GooglePlus::Comment.for_activity(id) 
    end

    # get the actor of this activity
    # @return [GooglePlus::Person] the actor for this activity
    def person
      @person ||= GooglePlus::Person.get(actor.id)
    end

    # List the people of a certain type of action on this activity
    # @param [Symbol] collection The collection to look up (ie: :plusoners, :resharers)
    # @return [GooglePlus::Cursor] a cursor for the list of people associated with this activity
    def list_people(collection)
      resource = "activities/#{id}/people/#{collection}"
      GooglePlus::Cursor.new(GooglePlus::Person, :get, resource)
    end

    # List the people that plusone'd this activity
    # @return [GooglePlus::Cursor] a cursor for the list of people that plusone'd this activity
    def plusoners
      list_people(:plusoners)
    end

    # List the people that reshared this activity
    # @return [GooglePlus::Cursor] a cursor for the list of people that reshared this activity
    def resharers
      list_people(:resharers)
    end

    # Load a new instance from an attributes hash
    # Useful if you have the underlying response data for an object - Generally, what you
    # want is #get though
    # @return [GooglePlus::Activity] An activity constructed from the attributes hash
    def initialize(hash)
      load_hash(hash)
    end

  end

end
