module ApplicationHelper
  def gravatar_link (user, option = {size: 250})
    hash = Digest::MD5.hexdigest(user.email.downcase)
    size = option[:size]
    "https://www.gravatar.com/avatar/#{hash}?s=#{size}"
  end

  def markdown
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML.new(escape_html: true, hard_wrap: true), autolink: true, tables: true)
  end

end
