class Mailer < ActionMailer::Base
  default from: "no-reply@relationshipforum.org"

  def new_conversation(user, conversation)
    @user         = user
    @conversation = conversation

    mail(to: user.email, subject: "New conversation!")
  end
end
