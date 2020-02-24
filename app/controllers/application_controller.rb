class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :sign_in_required, only: [:show]
  
    def after_sign_in_path_for(resource)
        profile_path
    end

    private
      def sign_in_required
        redirect_to login_path unless user_signed_in?
      end
  
end
