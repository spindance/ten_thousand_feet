require 'spec_helper'

module TenThousandFeet
  module API
    describe UserStatus do
      let!(:client) { TenThousandFeet.new auth: ENV['auth'] }
      let!(:users) do
        VCR.use_cassette('users') do
          client.get_users
        end
      end
      let!(:user) { users['data'][0] }
      let!(:id) { user['id'] }

      describe '#get_user_statuses' do
        it 'retrieves a list of statuses for a given user' do
          VCR.use_cassette('get_user_statuses') do
            status = client.get_user_statuses(id)
            expect(status['data']).to_not be_nil
          end
        end
      end

      describe '#create_user_status' do
        def user_status_attributes
          {
            status: 'ITO'
          }
        end

        it 'creates a new status for a given user' do
          VCR.use_cassette('create_user_status') do
            client.create_user_status(id, user_status_attributes)
            status = client.get_user_statuses(id)
            expect(status['data'][0]['status']).to eq 'ITO'
          end
        end
      end
    end
  end
end
