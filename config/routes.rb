Rails.application.routes.draw do
  scope :api do
    get '/redirect', to: 'links#redirect'
    get '/redirect/:url_hash', to: 'links#redirect'
    get '/links', to: 'links#index'
    post '/links', to: 'links#create'
    delete '/links/:id', to: 'links#destroy'
    get '/clicks', to: 'clicks#index'
    post '/signin', to: 'user_token#create'
    post '/signup', to: 'users#create'
  end
end
