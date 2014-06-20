module PostsHelper
  def markdown(data)
    return "" unless data.present?

    @html_renderer  ||= CustomRenderer.new(filter_html: true,
                                           hard_wrap: true,
                                           link_attributes: { target: "_blank" })

    @renderer       ||= Redcarpet::Markdown.new(@html_renderer,
                                               no_intra_emphasis: true,
                                               autolink: true,
                                               tables: false,
                                               strikethrough: true,
                                               superscript: false,
                                               underline: true,
                                               prettify: true,
                                               highlight: true)

    @renderer.render(data).html_safe
  end

  def country_flag(country)
    if !country
      ""
    else
      image_tag("flags/#{country.to_s.downcase}.png")
    end
  end
end
