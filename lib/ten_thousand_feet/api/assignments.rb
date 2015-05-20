module TenThousandFeet
  module API
    module Assignments
      def get_assignments(user_id, options = {})
        get("/users/#{user_id}/assignments", options)
      end

      def show_assignment(id, user_id, options = {})
        get("/users/#{user_id}/assignments/#{id}", options)
      end

      def create_assignment(user_id, options = {})
        post("/users/#{user_id}/assignments", options)
      end

      def delete_assignment(id, user_id, options = {})
        delete("/users/#{user_id}/assignments/#{id}", options)
      end
    end
  end
end
