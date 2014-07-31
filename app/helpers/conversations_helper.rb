module ConversationsHelper
  def conversation_title(conversation)
    users = conversation.users.select { |u| u != current_user }
    users.join(", ")
  end

  def unread_messages(conversation)
    read_at = conversation.conversations_users.where(user_id: current_user.id).first.read_at

    if read_at.blank?
      conversation.chats.count
    else
      conversation.chats.where("created_at > ?", read_at).count
    end
  end

  def total_unread_messages
    ConversationsUser.joins("INNER JOIN (SELECT conversation_id, MAX(created_at) AS last_chat_at FROM chats GROUP BY conversation_id) AS chats ON chats.conversation_id = conversations_users.conversation_id").
      where(user_id: current_user.id).
      where("conversations_users.read_at IS NULL OR conversations_users.read_at < chats.last_chat_at").
      count
  end
end
