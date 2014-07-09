class ForumsController < ApplicationController
  before_action :set_forum, except: [:index]

  def index
    @forums = Forum.all
  end

  private
  def set_forum
    @forum = Forum.friendly.find(params[:id])
  end
end
