$LOAD_PATH.unshift File.dirname(__FILE__) + "/lib"
require 'google_plus/version'

spec = Gem::Specification.new do |s|
  s.name = 'google_plus'
  s.author = 'John Crepezzi'
  s.description = 'Google+ Ruby Gem'
  s.email = 'john.crepezzi@gmail.com'
  s.add_development_dependency 'rspec'
  s.add_dependency 'rest-client', '~> 1.6.1'
  s.add_dependency 'json'
  s.files = Dir['lib/**/*.rb'] + ['README.md']
  s.has_rdoc = true
  s.homepage = 'http://github.com/seejohnrun/google_plus'
  s.platform = Gem::Platform::RUBY
  s.require_paths = ['lib']
  s.summary = 'Ruby Gem for the Google+ API'
  s.test_files = Dir.glob('spec/*.rb')
  s.version = GooglePlus::VERSION
  s.rubyforge_project = 'google_plus'
end
