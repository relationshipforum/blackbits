class ChatsController < ApplicationController
  include Tubesock::Hijack
  before_filter :authenticate_user!

  def socket
    REDIS.sadd("user_list", current_user.username)

    hijack do |tubesock|
      redis_thread = Thread.new do
        Redis.new(url: REDIS_URL).subscribe "chat" do |on|
          on.message do |channel, message|
            if message.present?
              hash = JSON.parse(message)
              hash["message"] = Rinku.auto_link(hash["message"], :all, 'target="_blank"')
              hash[:timestamp] = Time.now.iso8601
              tubesock.send_data(JSON(hash))
            end
          end
        end
      end

      tubesock.onmessage do |m|
        if m.present?
          Chat.create(user: current_user, message: m)

          Redis.new(url: REDIS_URL).publish "chat", JSON({
            username: current_user.username,
            slug: current_user.slug,
            message: m
          })
        end
      end
      
      tubesock.onclose do
        REDIS.srem("user_list", current_user.username)
        redis_thread.kill
      end
    end
  end

  def create
    @chat = Chat.new(chat_params)

    if @chat.save
      render :show, status: :created, location: @chat
    end
  end
end
