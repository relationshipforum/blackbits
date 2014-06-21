class ForumsController < ApplicationController
  before_action :set_forum, except: [:index]

  def index
    @forums = Forum.all
  end

  def show
    @submissions = Submission.includes(posts: [:author]).includes(:forum).where(forum_id: @forum.id).order("updated_at DESC")
  end

  private
  def set_forum
    @forum = Forum.friendly.find(params[:id])
  end
end
