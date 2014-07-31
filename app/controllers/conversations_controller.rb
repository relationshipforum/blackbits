class ConversationsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :set_conversations

  def show
    @conversation = current_user.conversations.find(params[:id])
    @conversation.read_by!(current_user)
  end

  def create
    recipients = params.require(:recipients).to_s.split(",").map do |recipient|
      User.find_by(username: recipient.to_s.strip) rescue nil
    end

    conversation = Conversation.create(user_id: current_user.id)

    (recipients | [current_user]).each do |user|
      conversation.conversations_users.create(user_id: user.id)
    end

    head :ok
  end

  private
  def set_conversations
    @conversations = current_user.conversations.all
  end
end
