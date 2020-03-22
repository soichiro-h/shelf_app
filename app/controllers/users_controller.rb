class UsersController < ApplicationController
  
  def show
    @user = current_user
    #debugger
  end
  
  
end
