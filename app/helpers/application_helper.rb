module ApplicationHelper
  def page_title(page_title = '')
    ENV['SITENAME'] = 'Narablog' unless ENV['SITENAME'].present?

    title = sitename = ENV['SITENAME']
    title = "#{sitename} - #{page_title}" if page_title.present?
    content_for :title, title
  end
end

class String
  def to_html
    Kramdown::Document.new(self, input: 'GFM').to_html
  end
end
