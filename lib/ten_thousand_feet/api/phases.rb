module TenThousandFeet
  module API
    module Phases

      def get_phases(project_id, options={})
        get("/projects/#{project_id}/phases", options)
      end

      def create_phase(project_id, options={})
        post("/projects/#{project_id}/phases", options)
      end

      def update_phase(project_id, phase_id, options={})
        put("/projects/#{project_id}/phases/#{phase_id}", options)
      end
    
    end
  end
end