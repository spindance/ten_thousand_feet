require 'pry'
require 'rest-client'
require 'ten_thousand_feet/client'
require 'ten_thousand_feet'
require 'yaml'

$AUTH = YAML.load_file('auth.yml')