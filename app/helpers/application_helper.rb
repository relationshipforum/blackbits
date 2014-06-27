module ApplicationHelper
  def count(key, options = {})
    @keys       ||= {}
    @keys[key]  ||= (options[:start_at] || 1) - 1
    @keys[key]   += 1
  end

  def avatar(user = current_user)
    image_tag(user.avatar_url, class: "avatar", height: 40, width: 40)
  end

  def body_class
    kls = []
    kls << "theme-default"
    kls << "no-main-menu" unless content_for?(:menu)
    kls << "page-mail" if controller_name == "messages"
    kls << content_for(:body_class) if content_for?(:body_class)

    kls.join(" ")
  end

  def unseen_chats_label
    return if controller_name == "chats"

    if user_signed_in?
      count = Chat.where("created_at > ?", current_user.last_chatted_at).count
      "<span class='label' style='background:green'>#{count}</span>".html_safe if count > 0
    end
  end
end
