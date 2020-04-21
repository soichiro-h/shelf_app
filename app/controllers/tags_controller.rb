class TagsController < ApplicationController
  
  
  def index
    @user = current_user
    @tags = @user.tags
    flash.now[:notice] = @user.flash if @user.flash
    @user.update_attributes(flash: nil)
    
  end
  
  def tag_has_errors?
    if !@tag.valid?
      if @tag.tag_title.empty?
        @error_msg = "1文字以上入力してください"
      elsif @tag.tag_title.length >= 9
        @error_msg = "8文字以内で入力してください"
      else
        @error_msg = "既にタグ登録されています"
      end
      
      gon.error_msg = @error_msg
      
      @user = User.find(params[:user_id])
      @tags = @user.tags
      sign_in @user 
      render :index
      
    else  
      if @tag.save
        @user = User.find(params[:user_id])
        @user.update_attributes(flash: "追加しました")
        redirect_to tags_path
      end
    end
  end
  
  def create
    @tag =Tag.new(user_id: "#{params[:user_id]}", tag_title: "#{params[:new_tag_title]}")
    
    tag_has_errors?
    
  end
  
  def clear_tags_error
    redirect_to tags_path
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
