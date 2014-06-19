class UsersController < ApplicationController
  def index
    @users = User.order("created_at ASC")
  end

  def show
  end
end
