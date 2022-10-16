Rails.application.routes.draw do

  devise_for :admins, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }

  namespace :admin do
    root to: 'homes#top'
    resources :users, only: [:index, :show, :edit, :update]
    get 'users/:id/post' => 'users#post', as: 'user_post'
    resources :posts, only: [:index, :show, :destroy] do
      resources :comments, only: [:destroy]
    end
    get 'posts/search'
    resources :tags, only: [:index, :destroy]
  end

  scope module: 'public' do
    root to: 'homes#top'

    get 'users/mypage' => 'users#show'
    get 'users/information/edit' => 'users#edit'
    patch 'users/information' => 'users#update'
    get 'users/confirm'
    patch 'users/withdraw'

    post 'posts/detail'
    get 'posts/search'
    resources :posts, only: [:index, :new, :create, :show, :edit, :update, :destroy] do
      resources :comments, only: [:new, :create] do
        resource :goods, only: [:create, :destroy]        #URLにgoodのidを含む必要がない
      end
      resource :bookmarks, only: [:create, :destroy]      #URLにbookmarkのidを含む必要がない
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
