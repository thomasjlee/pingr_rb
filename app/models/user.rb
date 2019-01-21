class User < ApplicationRecord
  include Clearance::User
  has_many :pings, foreign_key: :recipient_id

  def username
    email.split('@').first
  end

  # TESTME
  def unread_pings
    self.pings.where(read_at: nil).order(created_at: :desc)
  end

  def appear
    update_column :online, true
    ActionCable.server.broadcast('presence_channel', user_id: id, online: true, username: username)
  end

  def disappear
    update_column :online, false
    ActionCable.server.broadcast('presence_channel', user_id: id, online: false, username: username)
  end
end
