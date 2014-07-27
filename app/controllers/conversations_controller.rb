class ConversationsController < ApplicationController
  def index
    @conversations = current_user.conversations.all
  end
end
