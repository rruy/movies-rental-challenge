Rails.application.routes.draw do
  root 'movies#index'

  resources :movies, only: [:show] do
    post '/rent_by_user/:user_id', to: 'rentals#create_rent'
    post '/add_favorites/:user_id', to: 'favorite_movies#create'
    get 'search/:query', to: 'movies#search', on: :collection
  end

  resources :rentals, only: %i[index create] do
    get '/rented_by_user/:user_id', to: 'rentals#rented_by_user', on: :collection
    post '/rented/:user_id/', to: 'rentals#create', on: :collection
  end

  resources :users, only: [:show] do
    get '/:user_id/favorites', to: 'favorite_movies#favorites_by_user', on: :collection
    get '/:user_id/recommend', to: 'recommendations#recommend', on: :collection

    get '/:user_id/rented', to: 'rentals#rented_by_user', on: :collection
    post '/rented_return/:movie_id', to: 'rentals#rented_return'
  end

  resources :recommendations, only: [:recommend]
end
