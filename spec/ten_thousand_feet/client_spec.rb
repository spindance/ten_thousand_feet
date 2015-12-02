require 'spec_helper'

module TenThousandFeet
  describe Client do
    it 'Sets the value of the auth token on the client' do
      client = TenThousandFeet.new({ auth: ENV['auth'] })
      expect(client.auth).to eq ENV['auth']
    end
  end
end
