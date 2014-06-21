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

  def show
  end

  private
  def update_user_params
    params.require(:user).permit(:avatar_url, :title, :country, :location, :signature, :password, :password_confirmation)
  end
end
