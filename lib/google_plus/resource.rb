require 'restclient'

module GooglePlus

  module Resource

    # Base resource URI - includes trailing slash
    BASE_URI = 'https://www.googleapis.com/plus/v1/'

    # Make a request to an external resource
    def make_request(method, resource, params = {})
      params[:key] = GooglePlus.api_key unless GooglePlus.api_key.nil?
      params[:access_token] = GooglePlus.access_token unless GooglePlus.access_token.nil?
      params[:pp] = '0' # google documentation is incorrect, it says 'prettyPrint'
      begin
        RestClient.get "#{BASE_URI}#{resource}", :params => params
      rescue RestClient::Forbidden => e
        # TODO
        puts e.response.body
      rescue SocketError => e
        throw GooglePlus::ConnectionError
      rescue RestClient::ResourceNotFound
        nil
      end
    end

  end

end
