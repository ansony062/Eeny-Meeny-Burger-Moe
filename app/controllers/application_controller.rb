class ApplicationController < ActionController::Base
  #before_action :configure_permitted_paramerters, if: :devise_controller? #devise関係画面に行ったときに？
  
  #def configure_permitted_paramerters
  #  devise_paramerter_santizer.permit(:sign_up, key: [:email])
  #end
end
