module RelationshipHelper
  
  #START E' UNA CLASSE USER, END È UN ID
  def count_likes(start_user, end_user)
    start_user.likes.joins(:post).where('likes.post_id = posts.id AND posts.user_id = ?', end_user).count
  end

  def count_comments(start_user, end_user)
    start_user.comments.count_by_sql("
      SELECT count(*)
      FROM comments, posts
      WHERE comments.post_id = posts.id AND posts.user_id = #{end_user} AND comments.user_id = #{start_user.id}
    ")
  end
    
end
