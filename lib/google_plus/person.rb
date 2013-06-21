module GooglePlus

  # A Person in Google Plus
  class Person

    extend GooglePlus::Resource
    include GooglePlus::Entity

    # Get a person by id
    # @param [String] user_id the id of the user to look up
    # @option params [Symbol] :key A different API key to use for this request
    # @option params [Symbol] :user_ip The IP of the user on who's behalf this request is made
    # @return [GooglePlus::Person] a person object representing the person we're looking up,
    #   if it is found - otherwise, return nil
    def self.get(user_id, params = {})
      data = make_request(:get, "people/#{user_id}", params)
      Person.new(JSON.parse(data)) if data
    end
    #Get a list of people who are visible to the app
    
    def self.list(user_id,params = {})
      data = make_request(:get, "people/#{user_id}/people/visible",params)
      Person.new(JSON.parse(data)) if data
      

    # Search for a person
    # @param [String] query The query string to search for
    # @option params [Symbol] :key A different API key to use for this request
    # @option params [Symbol] :user_ip The IP of the user on who's behalf this request is made
    # @return [GooglePlus::Cursor] a cursor for the people found in the search
    def self.search(query, params = {})
      params[:query] = query
      resource = 'people'
      GooglePlus::Cursor.new(self, :get, resource, params)
    end

    # List the activities for this person
    # @return [GooglePlus::Cursor] a cursor of activities for this person
    def list_activities(params = {})
      GooglePlus::Activity.for_person(id, params)
    end

    # Load a new instance from an attributes hash
    # Useful if you have the underlying response data for an object - Generally, what you
    # want is #get though
    # @return [GooglePlus::Person] A person constructed from the attributes hash
    def initialize(hash)
      load_hash(hash)
    end

  end

end
