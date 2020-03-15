class RegistrationsController < Devise::RegistrationsController
  #before_action :debug, only: [:update]
  #after_action :debug, only: [:update]
 
  #デフォルトtag の生成
  def add_default_tags
  end
  
  #デバッグ用
  def debug
    debugger
  end


  protected

    def after_update_path_for(resource)
      profile_path
    end

end
