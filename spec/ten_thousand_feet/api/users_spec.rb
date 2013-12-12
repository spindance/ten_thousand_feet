require 'spec_helper'

module TenThousandFeet
  module API
    describe Users do
      
      let!(:client) { TenThousandFeet.new({ auth: $AUTH }) }
      let!(:users)  { client.get_users }
      let!(:user)   { users['data'][0] }
      let!(:id)     { user['id'] }

      describe '#get_users' do
        it 'retrieves a list of users' do
          name  = users['data'][0]['first_name']
          expect(name).to_not be_nil
        end
      end

      describe '#show_users' do
        it 'retrieves details of a specific user' do
          id    = users['data'][0]['id']
          user  = client.show_user(id)
          expect(user['id']).to eq id
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
          user_count_before = users['data'].count
          response = client.create_user(user_attributes)

          new_users  = client.get_users
          user_count_after = new_users['data'].count

          expect(user_count_after).to eq (user_count_before + 1)
        end
      end

      describe '#update_user' do
        context 'given a valid user' do

          context 'given valid params' do
            it 'updates an attribute for the user' do
              name  = "AustinPowers#{rand(0..100)}"
              response = client.update_user(id, { first_name: name })
              expect(response['first_name']).to eq name
            end
          end

          context 'given no params' do
            it 'returns the user unchanged' do
              response = client.update_user(id, {})
              expect(response['first_name']).to eq user['first_name']
            end
          end

        end
      end
    end
  end
end