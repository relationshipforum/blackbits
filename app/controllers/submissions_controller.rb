class SubmissionsController < ApplicationController
  before_action :set_submission, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @submissions = Submission.all
  end

  def show
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
