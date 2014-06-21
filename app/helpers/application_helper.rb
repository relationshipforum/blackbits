module ApplicationHelper
  def count(key, options = {})
    @keys       ||= {}
    @keys[key]  ||= (options[:start_at] || 1) - 1
    @keys[key]   += 1
  end

  def current_user_avatar
    image_tag(current_user.avatar_url, class: "avatar")
  end
end
