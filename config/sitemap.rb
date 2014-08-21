SitemapGenerator::Sitemap.default_host = "https://www.relationshipforum.org"

SitemapGenerator::Sitemap.create do
  # Put links creation logic here.
  #
  # The root path '/' and sitemap index file are added automatically for you.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host
  #
  # Examples:
  #
  # Add '/articles'
  #
  #   add articles_path, :priority => 0.7, :changefreq => 'daily'
  #
  # Add all articles:
  #
  #   Article.find_each do |article|
  #     add article_path(article), :lastmod => article.updated_at
  #   end

  add forums_path, priority: 0.9, changefreq: "weekly"

  Forum.find_each do |forum|
    add forum_path(forum), priority: 0.7, lastmod: forum.submissions.order("updated_at DESC").first.updated_at
  end

  Submission.find_each do |submission|
    add submission_path(submission), priority: 0.5, lastmod: submission.updated_at
  end
end
