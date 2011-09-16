require File.dirname(__FILE__) + '/google_plus/resource'
require File.dirname(__FILE__) + '/google_plus/cursor'

module GooglePlus

  autoload :Activity, File.dirname(__FILE__) + '/google_plus/activity'
  autoload :Person, File.dirname(__FILE__) + '/google_plus/person'

  class << self
    # set api key or access token
    attr_accessor :api_key, :access_token
  end

  # Return whether or not the we have an API
  # For historic purposes - since this client existed before there
  # was a GooglePlus API
  def self.has_api?
    true
  end

end
