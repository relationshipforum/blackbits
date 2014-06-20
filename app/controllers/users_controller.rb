class UsersController < ApplicationController
  def index
    @users = User.order("created_at ASC")
  end

  def update
    current_user.update_attributes(update_user_params)

    redirect_to :back, notice: "Updated successfully!"
  end

  def show
  end

  private
  def update_user_params
    params.require(:user).permit(:title, :country, :signature, :password, :password_confirmation)
  end
end
