require 'spec_helper'

module TenThousandFeet
  module API
    describe Assignments do
      
      let!(:client)  { TenThousandFeet.new({ auth: $AUTH }) }
      let!(:user)    { client.get_users['data'][0] }
      let!(:projects)  { 
        VCR.use_cassette('projects') do
          client.get_projects
        end
      }
      let!(:project)   { projects['data'][0] }
      let!(:assignments)  { 
        VCR.use_cassette('assignments') do
          client.get_assignments(user['id'])
        end
      }
      let!(:assignment)   { assignments['data'][0] }
      let!(:id)           { assignment['id'] }

      describe '#get_assignments' do
        it 'retrieves a list of assignments for a user' do
          VCR.use_cassette('get_assignments') do
            expect(assignments['data']).to_not be_nil
          end
        end
      end

      describe '#show_assignments' do
        it 'retrieves details of a assignment' do
          VCR.use_cassette('show_assignments') do
            id          = assignments['data'][0]['id']
            assignment  = client.show_assignment(id, user['id'])
            expect(assignment['id']).to eq id
          end
        end
      end

      describe '#create_assignment' do
        def assignment_attributes
          {
            project_id:  project['id'],
            starts_at:   '2013-10-10',
            ends_at:     '2013-10-10'
          }
        end

        it 'creates a new assignment' do
          VCR.use_cassette('create_assignment') do
            assignment_count_before = assignments['data'].count
            response = client.create_assignment(project['id'], user['id'], assignment_attributes)

            new_assignments  = client.get_assignments(user['id'])
            assignment_count_after = new_assignments['data'].count

            expect(assignment_count_after).to eq (assignment_count_before + 1)
          end
        end
      end

      describe '#delete_assignment' do
        context 'given a valid time entry' do
          it 'deletes the assignment' do
            VCR.use_cassette('delete_assignment') do
              response = client.delete_assignment(id, user['id'])
            end
          end
        end
      end
    end
  end
end