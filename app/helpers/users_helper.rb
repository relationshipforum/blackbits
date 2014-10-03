module UsersHelper
  def truncate_and_remove_quotes(body)
    body = body.to_s.gsub(/\>(.*)/, "")
    truncate body, length: 250
  end
end
