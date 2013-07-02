module GooglePlus

  # A modular extension for classes that make requests to the
  # Google Plus API
  module Resource

    # Base resource URI - includes trailing slash
    BASE_URI = 'https://www.googleapis.com/plus/v1/'

    # Make a request to an external resource
    def make_request(method, resource, params = {})
      # Put together the common params
      params[:key] ||= GooglePlus.api_key unless GooglePlus.api_key.nil?
      params[:userIp] = params.delete(:user_ip) if params.has_key?(:user_ip)
      params[:pp] = '0' # google documentation is incorrect, it says 'prettyPrint'
      # Add the access token if we have it
      headers = {}
      if token = params[:access_token] || GooglePlus.access_token
        headers[:Authorization] = "OAuth #{token}"
      end
      # And make the request
      begin
        RestClient.get "#{BASE_URI}#{resource}", headers.merge(:params => params)
      rescue RestClient::Unauthorized, RestClient::Forbidden, RestClient::BadRequest => e
        raise GooglePlus::RequestError.new(e)
      rescue SocketError => e
        raise GooglePlus::ConnectionError.new(e)
      rescue RestClient::ResourceNotFound, RestClient::RequestURITooLong
        nil
      end
    end

  end

end
