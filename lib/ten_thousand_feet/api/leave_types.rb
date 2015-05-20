module TenThousandFeet
  module API
    module LeaveTypes
      def get_leave_types(options = {})
        get('/leave_types', options)
      end

      def show_leave_type(id, options = {})
        get("/leave_types/#{id}", options)
      end
    end
  end
end
