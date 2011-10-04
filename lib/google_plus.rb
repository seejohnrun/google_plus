require 'bundler/setup'
require File.dirname(__FILE__) + '/google_plus/resource'
require File.dirname(__FILE__) + '/google_plus/cursor'

module GooglePlus

  autoload :Activity, File.dirname(__FILE__) + '/google_plus/activity'
  autoload :Comment, File.dirname(__FILE__) + '/google_plus/comment'
  autoload :Person, File.dirname(__FILE__) + '/google_plus/person'

  class << self
    attr_accessor :api_key
  end

  # Return whether or not the we have an API
  # For historic purposes - since this client existed before there
  # was a GooglePlus API
  def self.has_api?
    true
  end

end
