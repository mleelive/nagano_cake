Rails.application.routes.draw do
  devise_for :customers, skip: 'registrations', controllers: {
    sessions: 'public/sessions'
  }
  devise_for :admins, controllers: {
    sessions: 'admin/sessions'
  }

  devise_scope :customer do
    get 'edit' => 'public/registrations#edit'
    get '/customers/sign_up' => 'public/registrations#new', as: :new_customer_registration
    post '/customers' => 'public/registrations#create'
  end

  namespace :admin do
    resources :customers, only: [:index, :show, :edit, :update]
    resources :items, only: [:index, :new, :create, :show, :edit, :update]
    resources :categories, only: [:new, :create, :edit, :update]
    resources :orders, only: [:index, :show, :update]
    resources :order_items, only: [:update]
    root to: 'homes#top'
    get '/search', to: 'search#search'
  end

  scope module: :public do
    #resource :customers, only: [:show, :edit, :update]
    get '/customers/quit' => 'customers#quit'
    patch '/customers/out' => 'customers#out'
    resources :customers, only: [:show, :edit, :update]
    resources :items, only: [:index, :show]
    delete '/cart_items/destroy_all' => 'cart_items#destroy_all'
    resources :cart_items, only: [:index, :update, :create, :destroy, :show]
    get '/orders/thanks' => 'orders#thanks'
    resources :orders, only: [:new, :create, :index, :show]
    post '/orders/confirm' => 'orders#confirm'
    resources :deliveries, only: [:index, :create, :destroy, :edit, :update]
    root to: 'homes#top'
    get '/about' => 'homes#about'
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
