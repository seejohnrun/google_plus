require 'restclient'
require 'json'

# GooglePlus is a ruby library for accessing the Google Plus API
module GooglePlus

  autoload :Activity,         'google_plus/activity'
  autoload :Comment,          'google_plus/comment'
  autoload :Cursor,           'google_plus/cursor'
  autoload :Entity,           'google_plus/entity'
  autoload :Person,           'google_plus/person'
  autoload :Resource,         'google_plus/resource'

  autoload :ConnectionError,  'google_plus/errors/connection_error'
  autoload :RequestError,     'google_plus/errors/request_error'

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
