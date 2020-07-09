module ApplicationHelper
end

class String
  def to_html
    Kramdown::Document.new(self, input: 'GFM').to_html
  end
end
