require 'spec_helper'

describe GooglePlus::Resource do

  it 'should convert user_ip into userIp' do
    RestClient.should_receive(:get).with(anything, hash_including({ :params => hash_including({ :userIp => 'ip' })}))
    MockResource.make_request(:get, 'path', :user_ip => 'ip')
  end

end

class MockResource
  extend GooglePlus::Resource
end
