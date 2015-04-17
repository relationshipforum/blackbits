module ChatsHelper
  def sanitize_message(message)
    Rinku.auto_link(sanitize(message), :all, 'target="_blank"').html_safe
  end
end
