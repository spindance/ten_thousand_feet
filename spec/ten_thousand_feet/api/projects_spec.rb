require 'spec_helper'

module TenThousandFeet
  module API
    describe Projects do
      let!(:client) { TenThousandFeet.new auth: ENV['AUTH'] }
      let!(:projects) do
        VCR.use_cassette('projects') do
          client.get_projects
        end
      end
      let!(:project) { projects['data'][0] }
      let!(:id) { project['id'] }

      describe '#get_projects' do
        it 'retrieves a list of projects' do
          VCR.use_cassette('get_projects') do
            name = projects['data'][0]['name']
            expect(name).to_not be_nil
          end
        end
      end

      describe '#show_projects' do
        it 'retrieves details of a specific project' do
          VCR.use_cassette('show_projects') do
            id       = projects['data'][0]['id']
            project  = client.show_project(id)
            expect(project['id']).to eq id
          end
        end
      end

      describe '#create_projects' do
        def project_attributes
          {
            name:   '1 Billion Dollars',
            client: 'Dr. Evil'
          }
        end

        it 'creates a new project' do
          VCR.use_cassette('create_project') do
            project_count_before = projects['data'].count
            client.create_project(project_attributes)

            new_projects = client.get_projects
            project_count_after = new_projects['data'].count

            expect(project_count_after).to eq project_count_before + 1
          end
        end
      end

      describe '#update_project' do
        context 'given a valid project' do
          it 'updates an attribute for the project' do
            name = "#{rand(0..100)} Billion Dollars"
            response = client.update_project(id, name: name)
            expect(response['name']).to eq name
          end
        end
      end

      describe '#delete_project' do
        context 'given a valid project' do
          def project_attributes
            {
              name:   '1 Billion Dollars',
              client: 'Dr. Evil'
            }
          end

          it 'deletes a project' do
            VCR.use_cassette('delete_project') do
              new_project = client.create_project(project_attributes)
              client.delete_project(new_project['id'])
            end
          end
        end
      end

      describe '#get_project_time_entries' do
        it 'retrieves a list of time entries for a given project' do
          VCR.use_cassette('get_project_time_entries') do
            response = client.get_project_time_entries(id)
            expect(response['data']).to_not be_nil
          end
        end
      end

      describe '#get_project_time_users' do
        it 'retrieves a list of users for a given project' do
          VCR.use_cassette('get_project_time_users') do
            response = client.get_project_users(id)
            expect(response['data']).to_not be_nil
          end
        end
      end
    end
  end
end
