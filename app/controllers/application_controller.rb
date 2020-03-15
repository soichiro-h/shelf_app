class ApplicationController < ActionController::Base 
  add_flash_types :notice, :message, :success
  protect_from_forgery with: :exception
  protect_from_forgery with: :null_session
  before_action :sign_in_required, only: [:show, :index]
  before_action :configure_sign_up_params, :configure_account_update_params, if: :devise_controller?
  
    Flash = nil
  
    def after_sign_in_path_for(resource)
        profile_path
    end
    
    

    private
      def sign_in_required
        redirect_to login_path unless user_signed_in?
      end
  
      def configure_sign_up_params
        devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname])
      end
      
      def configure_account_update_params
        devise_parameter_sanitizer.permit(:account_update, keys: [:nickname])
        devise_parameter_sanitizer.permit(:account_update, keys: [:introduce_comment])
        devise_parameter_sanitizer.permit(:account_update, keys: [:avatar])
      end
      
end



      
