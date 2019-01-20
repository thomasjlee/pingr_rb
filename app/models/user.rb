class User < ApplicationRecord
  include Clearance::User
  has_many :pings, foreign_key: :recipient_id

  # TESTME
  def unread_pings
    self.pings.where(read_at: nil).order(created_at: :desc)
  end
end
