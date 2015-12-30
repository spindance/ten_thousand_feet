require 'spec_helper'

module TenThousandFeet
  describe Client do
    it 'Sets the value of the auth token on the client' do
      client = TenThousandFeet.new auth: ENV['AUTH']
      expect(client.auth).to eq ENV['AUTH']
    end
  end
end
