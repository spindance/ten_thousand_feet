require 'spec_helper'

module TenThousandFeet
  module API
    describe Phases do
      let!(:client) { TenThousandFeet.new auth: ENV['auth'] }
      let!(:projects) do
        VCR.use_cassette('projects') do
          client.get_projects
        end
      end
      let!(:project)   { projects['data'][0] }
      let!(:id)        { project['id'] }

      describe '#get_phases' do
        it 'retrieves a list of phases for a given project' do
          VCR.use_cassette('get_phases') do
            phases = client.get_phases(id)
            expect(phases['data']).to_not be_nil
          end
        end
      end

      describe '#create_phase' do
        def phase_attributes
          {
            phase_name: 'Groovy baby',
            starts_at:  '2014-09-15',
            ends_at:    '2014-10-15'
          }
        end

        it 'creates a new phase for a given project' do
          VCR.use_cassette('create_phase') do
            client.create_phase(id, phase_attributes)
            phase = client.get_phases(id)
            expect(phase['data'][0]['phase_name']).to eq phase_attributes[:phase_name]
          end
        end
      end

      describe '#update_phase' do
        def phase_attributes
          {
            phase_name: 'Groovy baby',
            starts_at:  '2014-09-15',
            ends_at:    '2014-10-15'
          }
        end

        it 'updates a given phases attributes' do
          phase       = client.create_phase(id, phase_attributes)
          phase_name  = "#{rand(0..100)} So Groovy"
          response    = client.update_phase(id, phase['id'], phase_name: phase_name)
          expect(response['phase_name']).to eq phase_name
        end
      end
    end
  end
end
