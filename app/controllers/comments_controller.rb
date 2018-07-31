class CommentsController < ApplicationController
  before_action :authenticate_user!
  
  # POST /comments
  # POST /comments.json
  def create
    @comment = current_user.comments.build(body: params[:comment][:body], post_id: params[:post_id])
    respond_to do |format|
      if @comment.save
        format.html {redirect_to root_path}
        format.json { render :show, status: :created, location: @comment }
      else
        format.html {redirect_to root_path}
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end


  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to @post, notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

end
