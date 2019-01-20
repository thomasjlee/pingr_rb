class User < ApplicationRecord
  include Clearance::User
  has_many :pings, foreign_key: :recipient_id

  # TESTME
  def unread_pings
    self.pings.where(read_at: nil).order(created_at: :desc)
  end

  def appear
    ActionCable.server.broadcast('appearance_channel', user_id: id, online: true)
  end

  def disappear
    ActionCable.server.broadcast('appearance_channel', user_id: id, online: false)
  end

  def online?
    Redis.new.get("user_#{self.id}_online") == "1"
  end
end
