# frozen_string_literal: true

module TagsHelper
  def tag_has_errors?
    if !@tag.valid?
      @error_msg = if @tag.tag_title.empty?
                     '文字を入力してください'
                   elsif @tag.tag_title.length >= 21
                     '20文字以内で入力してください'
                   else
                     '既にタグ登録されています'
                   end

      @user = User.find(params[:user_id])
      @tags = @user.tags
      sign_in @user
      render :index

    else
      if @tag.save
        @user = User.find(params[:user_id])
        @user.update_attributes(flash: '追加しました')
        redirect_to tags_path
      end
    end
  end

  def clear_tags_error
    redirect_to tags_path
  end
end
