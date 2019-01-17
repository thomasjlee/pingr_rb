class Ping < ApplicationRecord
  belongs_to :pinger, class_name: "User"
  belongs_to :recipient, class_name: "User"

  validate :cannot_ping_self
  validates_presence_of :pinger_id, :recipient_id

  def cannot_ping_self
    if recipient_id == pinger_id
      errors.add(:recipient_id, "can't ping yourself")
    end
  end
end
