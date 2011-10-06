require 'bundler/setup'
require File.dirname(__FILE__) + '/google_plus/resource'
require File.dirname(__FILE__) + '/google_plus/cursor'

# GooglePlus is a ruby library for accessing the 
module GooglePlus

  autoload :Activity, File.dirname(__FILE__) + '/google_plus/activity'
  autoload :Comment, File.dirname(__FILE__) + '/google_plus/comment'
  autoload :Person, File.dirname(__FILE__) + '/google_plus/person'

  class << self
    attr_accessor :api_key, :access_token
  end

  # Return whether or not there is a Google+ API
  # For historic purposes - since this client existed before there was a GooglePlus API
  # @return [Boolean] whether or not there is an API
  def self.has_api?
    true
  end

end
