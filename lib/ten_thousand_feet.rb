require "ten_thousand_feet/version"
require 'ten_thousand_feet/client'

module TenThousandFeet
  def self.new(options={})
    TenThousandFeet::Client.new(options)
  end
end
