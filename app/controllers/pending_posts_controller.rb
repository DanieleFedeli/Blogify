class PendingPostsController < ApplicationController
  before_action :set_pending_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:show]
  before_action :power_user, only: [:index, :accept, :destroy]
  # GET /pending_posts
  # GET /pending_posts.json
  def index
    @pending_posts = PendingPost.page(params[:page]).per(4)
  end

  # GET /pending_posts/1
  # GET /pending_posts/1.json
  def show
  end

  # GET /pending_posts/new
  def new
    @pending_post = current_user.pending_posts.new
  end

  # GET /pending_posts/1/edit
  def edit
  end

  # POST /pending_posts
  # POST /pending_posts.json
  def create
    @pending_post = current_user.pending_posts.build(pending_post_params)
    respond_to do |format|
      @pending_post.tag_list = pending_post_params[:tag_list]
      if @pending_post.save
        format.html { redirect_to @pending_post, notice: 'Pending post was successfully created.' }
        format.json { render :show, status: :created, location: @pending_post }
      else
        format.html { render :new }
        format.json { render json: @pending_post.errors, status: :unprocessable_entity }
      end
    end
  end

  def accept
    @pending_post = PendingPost.find(params[:pending_post_id])
    puts "ALL TAG BEFORE #{@pending_post.all_tags_list}"
    @pending_post.id = Post.count + 1
    @post = @pending_post.user.posts.build @pending_post.attributes
    
    logger.debug "ALL TAG: #{@pending_post.all_tags_list}"
    @pending_post.tag_list.map{ |p| @post.tag_list.add(p) }
    
    @pending_post.destroy!
    @post.save!
    
    logger.debug "ALL TAG POST: #{@post.all_tags_list}"
    
    respond_to do |format|
      format.html {redirect_to pending_posts_path}
    end
  end

  # PATCH/PUT /pending_posts/1
  # PATCH/PUT /pending_posts/1.json
  def update
    respond_to do |format|
      if @pending_post.update(pending_post_params)
        format.html { redirect_to @pending_post, notice: 'Pending post was successfully updated.' }
        format.json { render :show, status: :ok, location: @pending_post }
      else
        format.html { render :edit }
        format.json { render json: @pending_post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pending_posts/1
  # DELETE /pending_posts/1.json
  def destroy
    @pending_post.destroy
    respond_to do |format|
      format.html { redirect_to pending_posts_url, notice: 'Pending post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pending_post
      @pending_post = PendingPost.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pending_post_params
      params.require(:pending_post).permit(:title, :body, :tag_list)
    end

    def power_user
      redirect_to posts_path unless current_user.admin?
    end
end
