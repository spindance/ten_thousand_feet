require 'json'
require 'rest-client'

require 'ten_thousand_feet/api/users'
require 'ten_thousand_feet/api/phases'
require 'ten_thousand_feet/api/projects'
require 'ten_thousand_feet/api/user_status'
require 'ten_thousand_feet/api/assignments'
require 'ten_thousand_feet/api/time_entries'

module TenThousandFeet
  class Client

    attr_reader :auth

    include API::Users
    include API::Phases
    include API::Projects
    include API::UserStatus
    include API::Assignments
    include API::TimeEntries
    
    def initialize(options={})
      @auth = options[:auth]
    end

    def api_url
      "https://pre-prod-api.10000ft.com/api/v1"
    end

    def default_options
      { auth: @auth }
    end

    def get(path, options = {})
      params   = default_options.merge(options)
      response = RestClient.get(api_url + path, params)

      JSON.parse(response)
    end

    def post(path, options = {})
      params   = default_options.merge(options)
      response = RestClient.post(api_url + path, params)

      JSON.parse(response)
    end

    def put(path, options = {})
      params   = default_options.merge(options)
      response = RestClient.put(api_url + path, params)

      JSON.parse(response)
    end

    def delete(path, options = {})
      params   = default_options.merge(options)
      RestClient.delete(api_url + path, params)
    end
  end
end
