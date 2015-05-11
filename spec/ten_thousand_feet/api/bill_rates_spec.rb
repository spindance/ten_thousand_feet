require 'spec_helper'

module TenThousandFeet
  module API
    describe BillRates do

      let!(:client)   { TenThousandFeet.new(auth: $AUTH) }
      let!(:projects) {
        VCR.use_cassette('projects') do
          client.get_projects
        end
      }
      let!(:project) { projects['data'][0] }
      let!(:bill_rates) {
        VCR.use_cassette('get_bill_rates') do
          client.get_bill_rates(project['id'])
        end
      }
      let!(:bill_rate) { bill_rates['data'][0] }

      describe '#get_bill_rates' do
        it 'retrieves all bill rates for given project' do
          VCR.use_cassette('get_bill_rates') do
            id = bill_rates['data'][0]['id']
            bill_rate = client.get_bill_rates(project['id'])
            expect(bill_rate['data'][0]['id']).to eq id
          end
        end
      end

      describe '#get_bill_rate' do
        it 'retrieves a bill rate by id from a given project' do
          VCR.use_cassette('get_bill_rate') do
            id = bill_rates['data'][0]['id']
            test_bill_rate = client.get_bill_rate(project['id'], bill_rate['id'])
            expect(test_bill_rate['id']).to eq id
          end
        end
      end

    end
  end
end
