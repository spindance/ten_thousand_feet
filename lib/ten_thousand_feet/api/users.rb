module TenThousandFeet
  module API
    module Users

      def get_users(options={})
        get("/users", options)
      end

      def show_user(id, options={})
        get("/users/#{id}", options)
      end

      def create_user(options={})
        post("/users", options)
      end

      def update_user(id, options={})
        put("/users/#{id}", options)
      end
    
    end
  end
end