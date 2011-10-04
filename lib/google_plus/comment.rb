require 'json'
require File.dirname(__FILE__) + '/entity'

module GooglePlus

  class Comment

    extend GooglePlus::Resource
    include GooglePlus::Entity

    def self.get(comment_id, params = {})
      data = make_request(:get, "comments/#{comment_id}", params)
      Comment.new(JSON.parse(data)) if data
    end

    def self.for_activity(activity_id, params = {})
      resource = "activities/#{activity_id}/comments"
      GooglePlus::Cursor.new(self, :get, resource, params)
    end

    def initialize(hash)
      load_hash(hash)
    end

  end

end
