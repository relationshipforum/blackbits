module ApplicationHelper
  def count(key, options = {})
    @keys       ||= {}
    @keys[key]  ||= (options[:start_at] || 1) - 1
    @keys[key]   += 1
  end

  def avatar(user = current_user)
    image_tag(user.avatar_url, class: "avatar", height: 40, width: 40)
  end

  def meta_description
    s = '<meta name="description" content="'
    content = "Relationship Forum is the best love forum for romantic advice."

    if @submission.present?
      content = @submission.posts.first.body
    elsif @forum.present?
      content = @forum.description
    end

    content = truncate(content, length: 155, separator: " ", omission: "")
    s << content << '">'
    s.html_safe
  end

  def body_class
    kls = []
    kls << "theme-default"
    kls << "no-main-menu" unless content_for?(:menu)
    kls << "page-mail" if controller_name == "messages"
    kls << "page-search" if controller_name == "search"
    kls << content_for(:body_class) if content_for?(:body_class)

    kls.join(" ")
  end
end
