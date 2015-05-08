require 'json'
require 'rest-client'
require 'uri'

require 'ten_thousand_feet/api/users'
require 'ten_thousand_feet/api/phases'
require 'ten_thousand_feet/api/projects'
require 'ten_thousand_feet/api/user_status'
require 'ten_thousand_feet/api/assignments'
require 'ten_thousand_feet/api/time_entries'
require 'ten_thousand_feet/api/leave_types'
require 'ten_thousand_feet/api/bill_rates'

module TenThousandFeet
  class Client

    attr_reader :auth
    attr_reader :api_url

    include API::Users
    include API::Phases
    include API::Projects
    include API::UserStatus
    include API::Assignments
    include API::TimeEntries
    include API::LeaveTypes
    include API::BillRates

    def initialize(options={})
      @auth = options[:auth]
      @api_url = options[:api_url] || "https://api.10000ft.com/api/v1"
    end

    def default_options
      { auth: @auth }
    end

    def query_string(options)
      nodes  = (options.count - 1)
      params = "?"

      options.each_with_index do |(key, value), index|
        if index == nodes
          params += key.to_s + "=" + URI.encode(value)
        else
          params += key.to_s + "=" + URI.encode(value) + "&"
        end
      end

      params
    end

    def full_url(path, options = {})
      if options.empty?
        api_url + path
      else
        api_url + path + query_string(options)
      end
    end

    def get(path, options = {})
      response = RestClient.get(full_url(path), {params: default_options.merge(options) })

      JSON.parse(response)
    end

    def post(path, options = {})
      response = RestClient.post(full_url(path, default_options), options)

      JSON.parse(response)
    end

    def put(path, options = {})
      response = RestClient.put(full_url(path, default_options), options)

      JSON.parse(response)
    end

    def delete(path, options = {})
      RestClient.delete(full_url(path, default_options), options)
    end
  end
end
