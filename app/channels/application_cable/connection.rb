module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    # TESTME
    def connect
      self.current_user = find_verified_user
    end

    private
      # TESTME
      def find_verified_user
        if env[:clearance].signed_in?
          env[:clearance].current_user
        else
          reject_unauthorized_connection
        end
      end
  end
end
