class ForumsController < ApplicationController
  before_action :set_forum, except: [:index]

  def index
    @forums = Forum.all
  end

  def show
    query = Submission.includes(posts: [:author]).includes(:forum).order("updated_at DESC")

    if user_signed_in?
      @views = current_user.views.where("submission_id IN (?)", query.map(&:id))
    end

    @submissions = query.where(forum_id: @forum.id)
  end

  private
  def set_forum
    @forum = Forum.friendly.find(params[:id])
  end
end
