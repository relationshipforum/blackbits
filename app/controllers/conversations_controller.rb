class ConversationsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :set_conversations

  def show
    @conversation = current_user.conversations.find(params[:id])
    @conversation.read_by!(current_user)
  end

  def create
    recipients = params.require(:recipients).to_s.split(",").map do |recipient|
      User.lookup(recipient)
    end.compact

    if recipients.present?
      conversation = Conversation.create(user_id: current_user.id)

      (recipients | [current_user]).each do |user|
        conversation.conversations_users.create(user_id: user.id)
      end

      recipients.each do |recipient|
        Mailer.new_conversation(recipient, conversation).deliver if recipient.conversation_notification?
      end

      render json: conversation.id
    else
      head :ok
    end
  end

  private
  def set_conversations
    @conversations = current_user.conversations.all
  end
end
