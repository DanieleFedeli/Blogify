module UsersHelper
  def image_for(user)
    if !current_user.avatar.url.present?
      user.avatar.url
    else
      'http://via.placeholder.com/150x150'
    end
  end

  def count_indicator(user)
    if user.posts.any?
      (user.posts.count / 4.to_f).ceil
    else
      0
    end
  end
end
