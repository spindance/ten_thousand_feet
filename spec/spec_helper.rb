require 'pry'
require 'rest-client'
require 'ten_thousand_feet/client'
require 'ten_thousand_feet'
require 'vcr'
require 'webmock'
require 'dotenv'

Dotenv.load '.env.test'
VCR.configure do |c|
  c.cassette_library_dir = 'fixtures/vcr_cassettes'
  c.hook_into :webmock
  c.allow_http_connections_when_no_cassette = true
end
