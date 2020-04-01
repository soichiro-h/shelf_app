class UsersController < ApplicationController
  
  def show
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
