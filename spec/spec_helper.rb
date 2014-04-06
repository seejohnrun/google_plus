require 'bundler/setup'
require 'google_plus'

Dir[File.dirname(__FILE__) + "/support/*.rb"].each {|file| require file }

unless TEST_API_KEY = ENV['API_KEY']
  puts 'please provide an API_KEY environment variable'
  exit 1
end
