require 'ten_thousand_feet/api/users'
require 'rest-client'
require 'json'

module TenThousandFeet
  class Client

    attr_reader :auth

    include API::Users
    
    def initialize(options={})
      @auth = options[:auth]
    end

    def api_url
      "https://vnext-api.10000ft.com/api/v1"
    end

    def get(path, options = {})
      JSON.parse( RestClient.get(api_url + path, options) )
    end

    def post(path, options = {})
      JSON.parse( RestClient.post(api_url + path, options) )
    end

    def put(path, options = {})
      JSON.parse( RestClient.put(api_url + path, options) )
    end

    def delete(path, options = {})
      JSON.parse( RestClient.delete(api_url + path, options) )
    end
  end
end
