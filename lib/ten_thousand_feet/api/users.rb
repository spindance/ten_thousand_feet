module TenThousandFeet
  module API
    module Users

      def get_users
        get("/users", { auth: self.auth })
      end

      def show_user(id)
        get("/users/#{id}", { auth: self.auth })
      end

      def create_user(options={})
        default_options = { auth: self.auth }
        post("/users/", default_options.merge(options))
      end

      def update_user(id, options={})
        default_options = { auth: self.auth }
        put("/users/#{id}", default_options.merge(options))
      end
    
    end
  end
end