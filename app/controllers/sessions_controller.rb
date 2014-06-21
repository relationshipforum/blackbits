class SessionsController < Devise::SessionsController
  def create
    super
    current_user.update_attributes(agent: request.user_agent)
  end
end
