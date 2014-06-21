module ApplicationHelper
  def count(key, options = {})
    @keys       ||= {}
    @keys[key]  ||= (options[:start_at] || 1) - 1
    @keys[key]   += 1
  end

  def avatar(user = current_user)
    image_tag(user.avatar_url, class: "avatar")
  end
end
