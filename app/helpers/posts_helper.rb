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
    country = country.to_s.strip

    if country.blank?
      ""
    else
      image_tag("flags/#{country.to_s.downcase}.png", alt: country)
    end
  end

  def gender_icon(author)
    if author.gender == 2
      kls = "male"
      color = "1d6c8d"
    elsif author.gender == 1
      kls = "female"
      color = "c87299"
    else
      return ""
    end

    "<i class='panel-title-icon fa fa-#{kls}' style='color:##{color}'></i>".html_safe
  end

  def thanks(author)
    stats = Thank.thank_stats_for(author)

    "#{stats[0]} times, #{stats[1]} posts"
  end
end
