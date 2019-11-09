Rails.application.routes.draw do
  scope :api do
    get '/redirect', to: 'links#redirect'
    get '/redirect/:url_hash', to: 'links#redirect'
    resources :links, only: [:index, :create, :destroy]
    get '/clicks', to: 'clicks#index'
    post '/signin', to: 'user_token#create'
    post '/signup', to: 'users#create'
  end
end
