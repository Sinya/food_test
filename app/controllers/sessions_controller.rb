class SessionsController < ApplicationController
  def new
  end

  def create
  	@user = User.find_by_email(params[:session][:email]) #用session裡面的email資料找到用戶
  	if @user && @user.authenticate(params[:session][:password]) #如果用話找到，密碼也正確，就登入
  		# sign-in our user
      sign_in(@user)
      flash[:success] = "Welcome back, #{@user.name}!"
      redirect_to @user
  	else
  		flash.now[:error] = "Invalid email/password combination"
  		render "new"
  	end
  end

  def destroy
    sign_out
    redirect_to root_path
  end
end
