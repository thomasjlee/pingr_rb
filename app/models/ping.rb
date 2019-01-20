class Ping < ApplicationRecord
  after_create :notify_pinged

  belongs_to :pinger, class_name: "User"
  belongs_to :recipient, class_name: "User"

  validate :cannot_ping_self
  validates_presence_of :pinger_id, :recipient_id

  private
    def cannot_ping_self
      if recipient_id == pinger_id
        errors.add(:recipient_id, "can't ping yourself")
      end
    end

    # TESTME
    def notify_pinged
      PingsChannel.broadcast_to(
        recipient,
        html: {
          ping: ApplicationController.render(
            partial: 'pings/ping',
            locals: { ping: self }
          ),
          mark_all_as_read: ApplicationController.render(
            partial: 'pings/mark_all_as_read'
          )
        }
      )
    end
end
