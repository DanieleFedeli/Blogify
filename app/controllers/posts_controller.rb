class PostsController < ApplicationController
  before_action :set_post, only: [:show, :destroy]
  before_action :power_user, only: [:destroy]

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)
    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @pending_post }
      else
        format.html { render :new }
        format.json { render json: @postt.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # GET /posts
  # GET /posts.json
  def index
    if params[:tag]
      @posts = Post.tagged_with(params[:tag]).page(params[:page]).per(4)
    elsif params[:query]
      @posts = Post.where('title LIKE ?', "%#{params[:query]}").page(params[:page]).per(4)
    else
      @posts = current_user.feed.page(params[:page]).per(4)
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

    def post_params
      params.require(:post).permit(:title, :body, :tag_list)
    end

    def power_user
      redirect_to posts_path unless current_user.admin? || current_user.id == @post.user_id
    end
end
