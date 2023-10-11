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
    resources :users, only: [:index, :show, :edit, :update]
    resources :posts, only: [:index, :show, :edit, :update]
    resources :comments, only: [:show, :destroy]
    resources :tags, only: [:index, :new, :edit, :update]
  end

  #顧客
  scope module: :public do
    root to: 'homes#top'
    get 'users/mypage' => 'users#show'
    get 'users/information/edit' => 'users#edit'
    patch 'users/information' => 'users#update'
    get 'users/confirm' => 'users#confirm'         #退会確認画面
    patch 'users/withdrawal' => 'users#withdrawal' #退会処理更新
    resources :users, only: [:edit, :update] do
      resource :relationships, only: [:create, :destroy]
      get 'followings' => 'relationships#followings', as: 'followings'
      get 'followers' => 'reltionships#followers', as: 'followers'
    end
    resources :posts, only: [:index, :show, :new, :edit, :update] do
      resource :favorites, only: [:create, :destroy]
      resources :comments, only: [:create, :destroy]
      resources :bookmarks, only: [:index, :create, :destroy]
    end
    resources :tags, only: [:index]
    get 'users/seach', to: 'searches#search'  #検索結果
  end

end
