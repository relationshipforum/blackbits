class ChatsController < ApplicationController
  include Tubesock::Hijack
  before_filter :authenticate_user!

  def socket
    REDIS.sadd("user_list.#{conversation_id}", current_user.username)

    hijack do |tubesock|
      redis_thread = Thread.new do
        Redis.new(url: REDIS_URL).subscribe "chat.#{conversation_id}" do |on|
          on.message do |channel, message|
            if message.present?
              hash = JSON.parse(message)
              hash["message"] = Rinku.auto_link(hash["message"], :all, 'target="_blank"')
              hash[:timestamp] = Time.now.iso8601
              Conversation.find(conversation_id).read_by!(current_user) unless conversation_id == "global"
              tubesock.send_data(JSON(hash))
            end
          end
        end
      end

      tubesock.onmessage do |m|
        if m.present?
          cid = conversation_id

          attrs = { user: current_user, message: m }
          attrs.merge!({ conversation_id: cid }) unless cid == "global"

          Chat.create(attrs)

          Redis.new(url: REDIS_URL).publish "chat.#{cid}", JSON({
            username: current_user.username,
            slug: current_user.slug,
            message: m.force_encoding("utf-8")
          })
        end
      end
      
      tubesock.onclose do
        REDIS.srem("user_list.#{conversation_id}", current_user.username)
        redis_thread.kill
      end
    end
  end

  private
  def conversation_id
    cid = params.require(:conversation_id)

    if cid == "global"
      return cid
    else
      current_user.conversations.find(cid.to_s).id
    end
  end
end
