module ApplicationHelper
end

class String
  def to_html
    Kramdown::Document.new(self).to_html
  end
end
