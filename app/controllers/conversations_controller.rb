class ConversationsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :set_conversations

  def show
    @conversation = current_user.conversations.find(params[:id])
  end

  def create
  end

  private
  def set_conversations
    @conversations = current_user.conversations.all
  end
end
