class PostsController < ApplicationController
  before_action :set_post, only: [:show, :destroy]
  before_action :power_user, only: [:destroy]

  # GET /posts
  # GET /posts.json
  def index
    if params[:tag]
      @posts = Post.tagged_with(params[:tag]).page(params[:page]).per(4)
    elsif params[:query]
      @posts = Post.where('title LIKE ?', "%#{params[:query]}").page(params[:page]).per(4)
    else
      @posts = Post.page(params[:page]).per(4)
    end

    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    def power_user
      redirect_to posts_path unless current_user.admin?
    end
end
