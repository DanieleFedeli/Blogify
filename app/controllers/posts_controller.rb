class PostsController < ApplicationController
  before_action :set_post, only: [:destroy]
  before_action :power_user, only: [:destroy]

  # GET /posts
  # GET /posts.json
  def index
    if params[:query]
      @posts = Post.where('title LIKE ?', "%#{params[:query]}")
    else
      @posts = Post.all
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

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:user_id, :body, :query)
    end

    def power_user
      redirect_to posts_path unless current_user.admin?
    end
end
