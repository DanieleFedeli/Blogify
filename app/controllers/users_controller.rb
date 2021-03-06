class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users/1
  # GET /users/1.json
  def show
    @posts ||= @user.posts.page(params[:page]).per(12)
    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /users/new
  def new
    @user ||= User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user ||= User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        unless(user_params[:avatar])
          Cloudinary::Uploader.upload(user_params[:avatar], 
            pulic_id: user_params[:username],
            :eager => [
              {:width => 300, :height => 300, :crop => :limit}, 
              {:width => 100, :height => 100, :crop => :limit}
            ])
        end
        format.html { redirect_to root_path, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def followers
    @user ||= User.find(params[:user_id])
    @followers = @user.followers
  end

  def following
    @user ||= User.find(params[:user_id])
    @following = @user.following
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user ||= User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.fetch(:user, {})
    end

    def update_resource(resource, params)
      resource.update_without_password(params)
    end
end
