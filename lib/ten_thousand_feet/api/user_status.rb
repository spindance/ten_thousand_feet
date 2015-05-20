module TenThousandFeet
  module API
    module UserStatus
      def get_user_statuses(user_id, options = {})
        get("/users/#{user_id}/statuses", options)
      end

      def create_user_status(user_id, options = {})
        post("/users/#{user_id}/statuses", options)
      end
    end
  end
end
