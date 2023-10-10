Rails.application.routes.draw do

  #管理者側
  devise_for :admin, skip: [:registrations, :passwords], controllers:{
    sessions: "admin/sessions"
  }
  #顧客側
  devise_for :users, skip: [:password], controllers:{
    registrations: "public/registrations",
    sessions: "public/sessions"
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  #管理者
  namespace :admin do
    get '/' => 'posts#index'
  end

  #顧客
  scope module: :public do
    root to: 'homes#top'
  end

end
