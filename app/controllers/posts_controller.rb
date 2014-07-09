class PostsController < ApplicationController
  before_action :set_submission, only: [:create]
  before_action :set_post, except: [:create, :thanks]
  before_action :authenticate_user!, except: [:index]

  def edit
  end

  def create
    @post = @submission.posts.new(post_params)
    @post.author = current_user

    if @post.save
      @submission.viewed!(current_user)
      if last_post_id_param
        render text: @submission.posts.where("id > ?", last_post_id_param).map { |p|
          render_to_string p
        }.join("\n")
      else
        render @post
      end
    else
      render json: { errors: @post.errors.first.to_s }
    end
  end

  def update
    @post.update_attributes(post_params)
    page = (@post.submission.posts.index(@post) / 10) + 1

    redirect_to submission_path(@post.submission, page: page, anchor: "post-#{@post.id}")
  end

  def destroy
    submission = @post.submission
    if submission.posts.first == @post
      submission.destroy

      render json: { redirect: true }
    else
      @post.destroy

      head :ok
    end
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

  def last_post_id_param
    last_post_id = params.permit(:last_post_id)[:last_post_id].to_i
    last_post_id > 0 ? last_post_id : nil
  rescue
    nil
  end
end
