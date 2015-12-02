require 'spec_helper'

module TenThousandFeet
  module API
    describe Users do
      let!(:client) { TenThousandFeet.new auth: ENV['auth'] }
      let!(:users) do
        VCR.use_cassette('users') do
          client.get_users
        end
      end
      let!(:user) { users['data'][0] }
      let!(:id) { user['id'] }

      describe '#get_users' do
        it 'retrieves a list of users' do
          VCR.use_cassette('get_users') do
            name = users['data'][0]['first_name']
            expect(name).to_not be_nil
          end
        end
      end

      describe '#show_users' do
        it 'retrieves details of a specific user' do
          VCR.use_cassette('show_users') do
            id    = users['data'][0]['id']
            user  = client.show_user(id)
            expect(user['id']).to eq id
          end
        end
      end

      describe '#create_user' do
        def user_attributes
          {
            first_name: 'Austin',
            last_name:  'Powers',
            email:      'austin@yeahbaby.com'
          }
        end

        it 'creates a new user' do
          VCR.use_cassette('create_user') do
            user_count_before = users['data'].count
            client.create_user(user_attributes)

            new_users = client.get_users
            user_count_after = new_users['data'].count

            expect(user_count_after).to eq user_count_before + 1
          end
        end
      end

      describe '#update_user' do
        context 'given a valid user' do
          it 'updates an attribute for the user' do
            name = "AustinPowers#{rand(0..100)}"
            response = client.update_user(id, first_name: name)
            expect(response['first_name']).to eq name
          end
        end
      end
    end
  end
end
