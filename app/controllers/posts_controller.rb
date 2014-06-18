class PostsController < ApplicationController
  before_action :set_submission, only: [:create]
  before_action :set_post, except: [:create, :thanks]
  before_action :authenticate_user!, except: [:index]

  def create
    @post = @submission.posts.new(post_params)
    @post.author = current_user
    @post.save

    render @post
  end

  def update
  end

  def destroy
    @post.destroy
    head :ok
  end

  def thanks
    @post = Post.find(params[:id])
    @post.thanks!(current_user)

    render @post
  end

  private
  def set_submission
    @submission = Submission.friendly.find(params[:submission_id])
  end

  def set_post
    @post = current_user.posts.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:body)
  end
end
