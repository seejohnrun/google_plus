require 'restclient'
require File.dirname(__FILE__) + '/errors/request_error'
require File.dirname(__FILE__) + '/errors/connection_error'

module GooglePlus

  module Resource

    # Base resource URI - includes trailing slash
    BASE_URI = 'https://www.googleapis.com/plus/v1/'

    # Make a request to an external resource
    def make_request(method, resource, params = {})
      params[:key] = GooglePlus.api_key unless GooglePlus.api_key.nil?
      params[:userIp] = params.delete(:user_ip) if params.has_key?(:user_ip)
      params[:pp] = '0' # google documentation is incorrect, it says 'prettyPrint'
      begin
        RestClient.get "#{BASE_URI}#{resource}", :params => params
      rescue RestClient::Forbidden, RestClient::BadRequest => e
        raise GooglePlus::RequestError.new(e)
      rescue SocketError => e
        raise GooglePlus::ConnectionError.new(e)
      rescue RestClient::ResourceNotFound
        nil
      end
    end

  end

end
