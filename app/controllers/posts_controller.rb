class PostsController < ApplicationController
  before_action :set_submission, except: :thanks
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

  def post_params
    params.require(:post).permit(:body)
  end
end
