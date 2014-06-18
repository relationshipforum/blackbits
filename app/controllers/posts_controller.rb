class PostsController < ApplicationController
  before_action :set_submission

  def create
    @post = @submission.posts.new(post_params)
    @post.author = current_user
    @post.save

    redirect_to @submission
  end

  private
  def set_submission
    @submission = Submission.friendly.find(params[:submission_id])
  end

  def post_params
    params.require(:post).permit(:body)
  end
end
