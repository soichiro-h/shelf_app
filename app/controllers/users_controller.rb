class UsersController < ApplicationController
before_action :authenticate_user!

  def show
    user_session[:test] = "popopo popo poopo op"
    @user = current_user
    #debugger
  end
  
  def comment_update
    @user = User.find(params[:user_id])
    @user.introduce_comment = params[:comment_area]
    @user.save
    redirect_to profile_path
  end
  
end
