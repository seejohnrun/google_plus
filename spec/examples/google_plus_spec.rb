require File.dirname(__FILE__) + '/../spec_helper'

describe GooglePlus do

  it 'should have an api' do
    GooglePlus.should have_api
  end

  describe 'with an access token' do

    before :all do
      GooglePlus.api_key = TEST_API_KEY
    end

  end

end
