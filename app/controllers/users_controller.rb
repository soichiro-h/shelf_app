# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
  end

  def comment_update
    @user = User.find(params[:user_id])
    @user.introduce_comment = params[:comment_area]
    @user.save
    redirect_to profile_path
  end
end
