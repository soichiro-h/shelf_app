class RegistrationsController < Devise::RegistrationsController
  #after_action :debugg, only: [:update]
  after_action :welcome_treat, only: [:create], if: -> { current_user }
 
  def welcome_treat
    @user = current_user
    add_default_tags
    add_default_comment
    #debugger
  end
  
  #デフォルトtag の生成
  def add_default_tags
    tags = ["ビジネス", "自己啓発", "語学", "フィクション", "アート", "娯楽", "健康", "テクノロジー", "社会", "教育" ]
    tags.each { |t| 
      Tag.create!(tag_title: t, user_id: @user.id)
    }
  end
  
  #デフォルトコメント の登録
  def add_default_comment
    @user.update(introduce_comment: "シェルフへようこそ！\n本をたくさん登録して\nナレッジの整理に役立てて下さいね♪")
  end
  

  protected

    def after_update_path_for(resource)
      profile_path
    end

end
