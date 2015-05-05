require 'spec_helper'

module TenThousandFeet
  module API
    describe TimeEntries do
      
      let!(:client)  { TenThousandFeet.new({ auth: $AUTH }) }
      let!(:user)    { client.get_users['data'][0] }
      let!(:projects)  { 
        VCR.use_cassette('projects') do
          client.get_projects
        end
      }
      let!(:project)   { projects['data'][0] }
      let!(:time_entries)  { 
        VCR.use_cassette('time_entries') do
          client.get_time_entries(user['id'])
        end
      }
      let!(:time_entry)   { time_entries['data'][0] }
      let!(:id)           { time_entry['id'] }

      describe '#get_time_entries' do
        it 'retrieves a list of time entries for a user' do
          VCR.use_cassette('get_time_entries') do
            hours  = time_entries['data'][0]['hours']
            expect(hours).to_not be_nil
          end
        end
      end

      describe '#show_time_entries' do
        it 'retrieves details of a specific time entry' do
          VCR.use_cassette('show_time_entries') do
            id          = time_entries['data'][0]['id']
            time_entry  = client.show_time_entry(id, user['id'])
            expect(time_entry['id']).to eq id
          end
        end
      end

      describe '#create_time_entry' do
        #Required parameters: :date, :hours, :leave_type_id/:project_id/:assignable_id
        def time_entry_attributes
          {
            hours:       10,
            date:        '2013-10-10',
            project_id:  project['id']
          }
        end

        it 'creates a new project' do
          VCR.use_cassette('create_time_entry') do
            time_entry_count_before = time_entries['data'].count
            response = client.create_time_entry(user['id'], time_entry_attributes)

            new_time_entries  = client.get_time_entries(user['id'])
            time_entry_count_after = new_time_entries['data'].count

            expect(time_entry_count_after).to eq (time_entry_count_before + 1)
          end
        end
      end

      describe '#update_time_entry' do
        context 'given a valid time entry' do
          it 'updates an attribute for the entry' do
            hours  = rand(0..100)
            response = client.update_time_entry(id, user['id'], { hours: hours })
            expect(response['hours']).to eq hours
          end
        end
      end

      describe '#get_all_time_entries' do
        it 'retrieves all time entries' do
          VCR.use_cassette('get_all_time_entries') do
            hours  = time_entries['data'][0]['hours']
            expect(hours).to_not be_nil
          end
        end
      end
    end
  end
end
