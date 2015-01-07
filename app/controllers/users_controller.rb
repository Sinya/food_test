class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :follow, :unfollow, :followers, :followed_users ]
  before_action :authenticate_user, except: [ :new, :create ]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
      if @user.save
        sign_in @user
        flash[:success] = "Welcome, #{@user.name}!"
          redirect_to root_path
      else
        render "new"
      end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
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

  def follow
    if current_user?(@user) # 這個用戶是你自己嗎
      flash[:error] = "You cannot follow yourself"
    elsif current_user.following?(@user) #已經關注這個用戶了
      flash[:error] = "You already follow #{@user.name}"
    else
      unless current_user.follow(@user).nil? #若關注成功
        flash[:success] = "You are following #{@user.name}"
      else
        flash[:error] = "Something went wrong. You cannot follow #{@user.name}"
      end
    end
    redirect_to @user
  end

  def unfollow
    if current_user.unfollow(@user) #如果成功取消關注
      flash[:success] = "You no longer follow #{@user.name}"
    else 
      flash[:error] = "You cannot unfollow #{@user.name}"
    end
    redirect_to @user
  end

  def followers
    @users = @user.followers
  end

  def followed_users
    @users = @user.followed_users
  end

  def show
    @posts = @user.posts
    @foods = @user.foods
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end



end
