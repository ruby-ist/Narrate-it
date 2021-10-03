module ApplicationHelper
  def gravatar_link (user, option = {size: 250})
    hash = Digest::MD5.hexdigest(user.email.downcase)
    size = option[:size]
    "https://www.gravatar.com/avatar/#{hash}?s=#{size}"
  end
end
