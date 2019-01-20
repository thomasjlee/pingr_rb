class PresenceChannel < ApplicationCable::Channel
  def subscribed
    stream_from "appearance_channel"
    redis.set("user_#{current_user.id}_online", "1")
    current_user.appear
  end

  def unsubscribed
    redis.del("user_#{current_user.id}_online")
    current_user.disappear
  end

  private
    def redis
      Redis.new url: ENV.fetch('REDISTOGO_URL', 'redis://localhost:6379')
    end
end
