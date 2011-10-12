require 'rspec/core/rake_task'

$LOAD_PATH.unshift File.dirname(__FILE__) + "/lib"
require 'google_plus/version'

task :build => :test do
  system "gem build google_plus.gemspec"
end

task :release => :build do
  # tag and push
  system "git tag v#{GooglePlus::VERSION}"
  system "git push origin --tags"
  # push the gem
  system "gem push google_plus-#{GooglePlus::VERSION}.gem"
end
 
RSpec::Core::RakeTask.new(:test) do |t|
  t.pattern = 'spec/**/*_spec.rb'
  fail_on_error = true # be explicit
end
 
RSpec::Core::RakeTask.new(:rcov) do |t|
  t.pattern = 'spec/**/*_spec.rb'
  t.rcov = true
  fail_on_error = true # be explicit
end
