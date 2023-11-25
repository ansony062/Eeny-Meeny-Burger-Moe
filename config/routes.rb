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

  devise_scope :user do
    get 'users/guest_sign_in', to: 'public/sessions#guest_sign_in'
    post 'users/guest_sign_in', to: 'public/sessions#guest_sign_in'

  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  #管理者
  namespace :admin do
    get '/' => 'posts#index'
    resources :users, only: [:index, :show, :edit, :update]
    resources :posts, only: [:index, :show, :edit, :update]
    resources :comments, only: [:destroy]
    resources :tags, only: [:index, :new, :edit, :update, :create, :destroy]
  end

  #顧客
  scope module: :public do
    root to: 'homes#top'
    get 'users/mypage' => 'users#mypage'
    get 'users/information/edit' => 'users#edit'
    patch 'users/information' => 'users#update'
    get 'users/confirm' => 'users#confirm'         #退会確認画面
    patch 'users/withdrawal' => 'users#withdrawal' #退会処理更新
    resources :users, only: [:show, :edit, :update] do
      resource :relationships, only: [:create, :destroy]
      get 'followings' => 'relationships#followings', as: 'followings'
      get 'followers' => 'relationships#followers', as: 'followers'
      resources :bookmarks, only: [:index]
    end
    get 'posts/edit' => 'posts#edit'               #投稿編集
    resources :posts, only: [:index, :show, :create, :new, :update, :destroy] do
      resource :favorites, only: [:create, :destroy]
      resources :comments, only: [:create, :destroy]
      resource :bookmarks, only: [:create, :destroy]
    end
    resources :tags, only: [:show, :new, :create, :edit, :update]
    get '/search', to: 'searches#search'  #検索結果
  end

end
