class TagsController < ApplicationController
  
  def index
    @user = current_user
    @tags = @user.tags
    current_user
  end
  
  def create
    @tag =Tag.new(user_id: "#{params[:user_id]}", tag_title: "#{params[:new_tag_title]}")
      if @tag.save
        redirect_to tag_path
      end
  end
  
  def destroy
    tag = Tag.find(params[:id])
    tag.destroy
    redirect_to tag_path
  end
  
  def update
    @user = User.find(params[:user_id])
    @tags = @user.tags
    @tags.each do |t|
      t.update_attribute(:tag_title, params[:"#{t.id}"][:tag_title])
    end
    redirect_to tag_path
  end
  
end