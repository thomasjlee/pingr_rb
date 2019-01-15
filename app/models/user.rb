class User < ApplicationRecord
  include Clearance::User
  has_many :pings, foreign_key: :recipient_id
end
