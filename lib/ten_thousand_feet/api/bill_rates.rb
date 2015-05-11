module TenThousandFeet
  module API
    module BillRates

      def get_bill_rate(project_id, bill_rate_id, options={})
        get("/projects/#{project_id}/bill_rates/#{bill_rate_id}", options)
      end

      def get_bill_rates(project_id, options={})
        get("/projects/#{project_id}/bill_rates", options)
      end

    end
  end
end
