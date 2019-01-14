class Ping < ApplicationRecord
  belongs_to :pinger, class_name: "User"
  belongs_to :recipient, class_name: "User"

  validates_presence_of :pinger_id, :recipient_id
end
