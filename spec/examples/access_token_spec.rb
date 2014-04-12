require 'spec_helper'

describe GooglePlus::AccessToken do
  let(:params) {
    {
      client_id: 'google_client_id',
      client_secret: 'google_client_secret',
      refresh_token: 'fresh_new_token'
    }
  }
  let(:access_token) { GooglePlus::AccessToken.get(params) }

  describe "#get" do
    it "should send the right request" do
      RestClient.should_receive(:post) { |url, request_params|
        url.should == 'https://accounts.google.com/o/oauth2/token'
        request_params[:client_id].should == params[:client_id]
        request_params[:client_secret].should == params[:client_secret]
        request_params[:refresh_token].should == params[:refresh_token]
        request_params[:grant_type].should == 'refresh_token'
        access_token_json_response
      }

      access_token
    end

    it "should get a new access token" do
      RestClient.stub(:post).and_return(access_token_json_response)
      access_token.should == access_token_response["access_token"]
    end
  end
end