class RelationshipsController < ApplicationController

  def create
    @user = User.find(params[:followed_id])
    current_user.follow(@user)
    respond_to do |format|
      format.html
      format.js
    end
  end

  def destroy
    @relationship = Relationship.find(params[:id])
    @user = @relationship.followed
    current_user.unfollow(@user)
    respond_to do |format|
      format.html redirect_to user
      format.js
    end
  end
end
