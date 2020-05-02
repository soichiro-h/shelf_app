class TagsController < ApplicationController
  include TagsHelper
  before_action :authenticate_user!, only: [:index ]
  
  def index
    @user = current_user
    @tags = @user.tags
    flash.now[:notice] = @user.flash if @user.flash
    @user.update_attributes(flash: nil)
    
  end
  
  def create
    @tag =Tag.new(user_id: "#{params[:user_id]}", tag_title: "#{params[:new_tag_title]}")
    tag_has_errors?
    
  end
  
  
  def destroy
    tag = Tag.find(params[:id])
    tag.update(deleted_at: Time.now)
    tag.destroy
    @user = User.find(tag.user_id)
    @user.update_attributes(flash: "削除しました")
    
    redirect_to tags_path
    
  end
  
  def update
    @user = User.find(params[:user_id])
    @tags = @user.tags
    @tags.each do |t|
      t.update(tag_title: params[:"#{t.id}"][:tag_title])
    end
    redirect_to tags_path
  end
  
end
