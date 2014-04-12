module GooglePlus
  class AccessToken
    BASE_URI = 'https://accounts.google.com/o/oauth2/token'

    def self.get(params)
      params.merge!(grant_type: 'refresh_token')
      response = RestClient.post(BASE_URI, params)
      JSON.parse(response)["access_token"]
    end
  end
end