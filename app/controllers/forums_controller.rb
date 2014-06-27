class ForumsController < ApplicationController
  before_action :set_forum, except: [:index]

  def index
    @forums = Forum.all
  end

  def show
    @submissions = Submission.includes(posts: [:author]).includes(:forum).where(forum_id: @forum.id).order("updated_at DESC")
    @views = current_user.views.where("submission_id IN (?)", @submissions.map(&:id)) if user_signed_in?
    @posted_submission_ids = Post.select("submission_id").where(author_id: current_user.id).where("submission_id IN (?)", @submissions.map(&:id)).map(&:submission_id) if user_signed_in?
  end

  private
  def set_forum
    @forum = Forum.friendly.find(params[:id])
  end
end
