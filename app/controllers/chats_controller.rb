class ChatsController < ApplicationController
  include Tubesock::Hijack

  def socket
    hijack do |tubesock|
      redis_thread = Thread.new do
        Redis.new(url: REDIS_URL).subscribe "chat" do |on|
          on.message do |channel, message|
            tubesock.send_data message
          end
        end
      end

      tubesock.onmessage do |m|
        # pub the message when we get one
        # note: this echoes through the sub above
        Chat.create(user: current_user, message: m)

        Redis.new(url: REDIS_URL).publish "chat", JSON({
          username: current_user.username,
          slug: current_user.slug,
          message: m
        })
      end
      
      tubesock.onclose do
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
