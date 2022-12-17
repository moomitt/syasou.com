Rails.application.routes.draw do
  devise_for :admins, skip: %i[registrations passwords], controllers: {
    sessions: 'admin/sessions'
  }

  devise_for :users, skip: [:passwords], controllers: {
    registrations: 'public/registrations',
    sessions: 'public/sessions'
  }

  namespace :admin do
    root to: 'homes#top'
    get 'users/:id/posts' => 'users#posts', as: 'user_posts'
    get 'users/:id/followings' => 'users#followings', as: 'user_followings'
    get 'users/:id/followers' => 'users#followers', as: 'user_followers'
    delete 'users/:id/user_image_destroy' => 'users#image_destroy', as: 'user_image_destroy'
    resources :users, only: %i[index show edit update]

    get 'posts/search_area/:id' => 'posts#search_area', as: 'search_area'
    get 'posts/search_prefecture/:id' => 'posts#search_prefecture', as: 'search_prefecture'
    resources :posts, only: %i[index show destroy] do
      resources :comments, only: [:destroy]
    end

    resources :tags, only: %i[index destroy]
  end

  scope module: 'public' do
    root to: 'homes#top'

    get 'users/mypage' => 'users#show'
    get 'users/posts' => 'users#posts'
    get 'users/bookmarks' => 'users#bookmarks'
    get 'users/followings' => 'users#followings'
    get 'users/followers' => 'users#followers'
    get 'users/information/edit' => 'users#edit'
    patch 'users/information' => 'users#update'
    get 'users/confirm'
    patch 'users/withdraw'
    delete 'users/user_image_destroy' => 'users#image_destroy', as: 'user_image_destroy'
    resources :users do
      resource :follows, only: %i[create destroy]
    end

    post 'posts/detail'
    get 'posts/user/:id' => 'posts#search_user', as: 'search_user'
    get 'posts/search_area/:id' => 'posts#search_area', as: 'search_area'
    get 'posts/search_prefecture/:id' => 'posts#search_prefecture', as: 'search_prefecture'
    resources :posts, only: %i[index new create show edit update destroy] do
      resources :comments, only: %i[create destroy] do
        resource :goods, only: %i[create destroy]        # URLにgoodのidを含む必要がない
      end
      resource :bookmarks, only: %i[create destroy]      # URLにbookmarkのidを含む必要がない
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
