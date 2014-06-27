class SubmissionsController < ApplicationController
  before_action :set_submission, only: [:show, :unread, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show, :unread]

  def index
    @submissions = Submission.includes(posts: [:author]).includes(:forum).order("updated_at DESC")
    @views = current_user.views.where("submission_id IN (?)", @submissions.map(&:id)) if user_signed_in?
    @posted_submission_ids = Post.select("submission_id").where(author_id: current_user.id).where("submission_id IN (?)", @submissions.map(&:id)).map(&:submission_id) if user_signed_in?
  end

  def show
    @page = params[:page].to_i || 1
    @posts = @submission.posts.page(@page)
    @submission.viewed!(current_user)
  end

  def unread
    post = @submission.first_unread_post(current_user)
    page = (@submission.posts.index(post) / 10) + 1

    redirect_to submission_path(@submission, page: page, anchor: "post-#{post.id}")
  end

  def edit
  end

  def create
    @submission = current_user.submissions.new(submission_params)
    @post = Post.new(post_params)

    if @submission.save
      @post.submission = @submission
      @post.author = current_user
      @post.save

      redirect_to @submission, notice: "Submission was successfully created."
    else
      redirect_to submissions_path, alert: "Error saving thread."
    end
  end

  def update
    if @submission.update(submission_params)
      redirect_to @submission, notice: "Submission was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @submission.destroy
    redirect_to submissions_path, notice: "Submission was successfully destroyed."
  end

  private
  def set_submission
    @submission = Submission.friendly.find(params[:id])
  end

  def submission_params
    params.require(:submission).permit(:title, :forum_id, posts_attributes: [:body])
  end

  def post_params
    params.require(:post).permit(:body)
  end
end
