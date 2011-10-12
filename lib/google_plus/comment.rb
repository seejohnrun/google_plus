require 'json'

module GooglePlus

  # A Comment in Google Plus
  class Comment

    extend GooglePlus::Resource
    include GooglePlus::Entity

    # Get a comment by id
    # @param [String] comment_id The id of the comment to look up
    # @option params [Symbol] :key A different API key to use for this request
    # @option params [Symbol] :user_ip The IP of the user on who's behalf this request is made
    # @return [GooglePlus::Comment] a comment object representing the comment we're looking up,
    #   if it is found - otherwise, return nil
    def self.get(comment_id, params = {})
      data = make_request(:get, "comments/#{comment_id}", params)
      Comment.new(JSON.parse(data)) if data
    end

    # Get a cursor of comments for an activity
    # @param [String] activity_id The id of the activity to look up comments for
    # @option params [Symbol] :key A different API key to use for this request
    # @option params [Symbol] :user_ip The IP of the user on who's behalf this request is made
    # @return [GooglePlus::Cursor] a cursor for listing the comments for this activity
    def self.for_activity(activity_id, params = {})
      resource = "activities/#{activity_id}/comments"
      GooglePlus::Cursor.new(self, :get, resource, params)
    end

    # Load a new instance from an attributes hash.
    # Useful if you have the underlying response data for an object - Generally, what you
    # want is #get though
    # @return [GooglePlus::Comment] A comment constructed from the attributes hash
    def initialize(hash)
      load_hash(hash)
    end

  end

end
