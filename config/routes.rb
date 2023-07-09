Rails.application.routes.draw do
  root 'movies#index'

  resources :movies, only: [] do
    resources :recommendations, only: %i[index create] do
      get '/users/:user_id', to: 'recommendations#recommend', on: :collection
    end

    post '/rent_by_user/:user_id', to: 'rentals#create'
    post '/add_favorites/:user_id', to: 'favorite_movies#create'
  end

  resources :rentals, only: %i[index create] do
    get '/rented_by_user/:user_id', to: 'rentals#rented_by_user', on: :collection
  end

  resources :users, only: [:show] do
    get '/:user_id/favorites', to: 'favorite_movies#favorites_by_user', on: :collection
    get '/:user_id/rented', to: 'rentals#rented_by_user', on: :collection
    post '/rented_return/:movie_id', to: 'rentals#rented_return'
  end
end


# Routes 

# /users/
# /users/:user_id
# /users/:user_id/favorites
# /users/:user_id/rented
# /users/:user_id/rented_return/:movie_id

# /movies/
# /movies/:movie_id
# /movies/:movie_id/recommendations/:user_id
# /movies/:movie_id/rent_by_user/:user_id
# /movies/:movie_id/add_favorites/:user_id

# Avaliar filmes