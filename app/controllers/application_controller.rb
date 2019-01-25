class ApplicationController < ActionController::Base
  before_action :update_last_seen_at, if: -> { signed_in? && current_user.last_seen_at < 5.minutes.ago }

  include Clearance::Controller

  private
    def update_last_seen_at
      if current_user.away? || current_user.offline?
        current_user.appear
      end
      current_user.update_column(:last_seen_at, DateTime.now)
    end
end
