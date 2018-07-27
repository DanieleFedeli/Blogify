module UsersHelper
  def count_indicator(user)
    if user.posts.any?
      (user.posts.count / 4.to_f).ceil
    else
      0
    end
  end
end
