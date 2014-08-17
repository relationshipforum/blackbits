class UsersController < ApplicationController
  def index
    @users = User.order("created_at ASC")
  end

  def update
    if current_user.update_attributes(update_user_params)
      redirect_to :back, notice: "Updated successfully!"
    else
      redirect_to :back, alert: "There was a problem with your submission."
    end
  end

  def root
    if user_signed_in? && current_user.whats_new_default?
      redirect_to submissions_path
    else
      redirect_to forums_path
    end
  end

  def show
    @user = User.friendly.find(params[:id])
  end

  private
  def update_user_params
    params.require(:user).permit(:avatar_url, :title, :country, :time_zone, :location, :signature, :password, :password_confirmation, :whats_new_default)
  end
end
