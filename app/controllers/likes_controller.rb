class LikesController < ApplicationController
  before_action :authenticate_user!
  def create
    @post = Post.find(params[:post_id])
    @like = current_user.likes.build(post_id: @post.id)

    if @like.save!
      respond_to do |format|
        format.js
        format.html
      end
    end
  end

  def destroy
    @like = Like.find(params[:id])
    @post = @like.post
    if @like.destroy!
      respond_to do |format|
        format.js
        format.html
      end
    end
  end

end
