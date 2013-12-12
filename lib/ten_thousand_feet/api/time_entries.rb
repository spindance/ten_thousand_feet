module TenThousandFeet
  module API
    module TimeEntries

      def get_time_entries(user_id, options={})
        get("/users/#{user_id}/time_entries", options)
      end

      def show_time_entry(id, user_id, options={})
        get("/users/#{user_id}/time_entries/#{id}", options)
      end

      def create_time_entry(user_id, options={})
        post("/users/#{user_id}/time_entries", options)
      end

      def update_time_entry(id, user_id, options={})
        put("/users/#{user_id}/time_entries/#{id}", options)
      end

      def delete_time_entry(id, user_id, project_id, options={})
        delete("projects/#{project_id}/users/#{user_id}/time_entries/#{id}", options)
      end
    
    end
  end
end