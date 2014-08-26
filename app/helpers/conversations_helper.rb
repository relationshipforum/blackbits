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
    @total_unread ||= current_user.unread_messages_count
  end
end
