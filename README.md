# Movie Rental API - Technical Challenge

## Overview

Welcome to the Movie Rental API technical challenge! This is a Ruby on Rails project that has been set up with basic models for `User` and `Movie`, and a `MoviesController` with some defined endpoints.

This application simulates part of a movie rental system, where users can rent movies, have favorite movies, and get recommendations based on their favorites.

Your task is to review the existing code, open Pull Requests to suggest any improvements, enhancements, or bug fixes, and reevaluate the existing business logic to propose your own improvements. While the application is functional as it stands, there is always room for improvement!

This project is configured for [Github Codespaces](https://github.com/codespaces), which allows you to work on the project in a fully configured, remote development environment. Feel free to use this feature and create a new Codespace for your repository to make the task execution easier.

The project also includes a seed file that pre-populates the database with users and movies, making it easier for you to test your changes.

## Existing Endpoints

### 1. `GET /movies`

This endpoint retrieves all the movies in the database and returns them in JSON format. Each movie object includes its `id`, `title`, `genre`, `rating`, and the number of `available_copies`.

### 2. `GET /movies/recommendations?user_id=<user_id>`

This endpoint generates a list of movie recommendations for a given user. It uses a basic recommendation engine that takes the user's favorite movies as input and generates recommendations based on those favorites. The response is a JSON array of recommended movie objects.

### 3. `GET /movies/user_rented_movies?user_id=<user_id>`

This endpoint retrieves all the movies that a user has currently rented. The user is identified by the `user_id` parameter in the URL. The response is a JSON array of movie objects that the user has rented.

### 4. `GET /movies/<movie_id>/rent?user_id=<user_id>`

This endpoint allows a user to rent a movie. The user is identified by the `user_id` parameter and the movie by the `id` parameter in the URL. 

If successful, it reduces the number of `available_copies` of the movie by 1 and adds the movie to the user's `rented` movies. The response is a JSON object of the rented movie.

## Your Task

1. **Cloning the repository**: Start by [cloning](https://docs.github.com/en/repositories/creating-and-managing-repositories/duplicating-a-repository) this repository to your local machine, then push it to your own GitHub account. Please, do not fork the repository, otherwise, other candidates will be able to see your solution.
2. **Suggesting changes**: Review the existing code and create Pull Requests (PR) with your proposed changes and explanations, based on the following aspects:
   - **Bad functioning**: Identify any issues (bugs, inefficiencies, etc.).
   - **Refactoring**: If necessary, refactor parts of the code to improve its quality and maintainability. Be sure to explain your reasoning in your PR.
   - **Rethinking the Business Logic**: Feel free to reevaluate the current business logic and assumptions that were previously made. If you have an alternative solution that makes more sense, or would improve the application, please propose it.

### Important Note

Remember, the main goal of this challenge is not to write a fully-functional application, but rather to demonstrate your coding, problem-solving, and communication skills. We value clean and efficient code, and we appreciate creative and thoughtful solutions to problems.

The code has dozens of potential improvements, and we don't expect you to work on all of them. Feel free to prioritize the ones you consider most important to address in **about 3 hours of work**.

_**Happy Coding!**_




# Informations about Challeger Refactor

I changed the original routes in order to padronize paths and don't use queries params

### Routes 

## Results of routes after refactored

| Method | Url  |  Description |
| ------ | ------ | ------ |
| GET | /users/  |  List all users 
| GET | /users/:user_id | Get user by id 
| GET | /users/:user_id/favorites | List all favorites movies of specific user 
| GET | /users/:user_id/rented | List rented movies of specific user 
| POST | /users/:user_id/rented_return/:movie_id | Mark movie as return rented of specific user 
| GET | /movies/ | List all movies with pagination - You can use query strings ?page=1&per_page=10 to paginate results 
| GET | /movies/:movie_id | Get movie by id 
| GET | /movies/:movie_id/recommendations/:user_id | Get recommendations by user based in our favorite movies 
| POST | /movies/:movie_id/rent_by_user/:user_id | Create a new record of rent by user_id and movie_id 
| POST | /movies/:movie_id/add_favorites/:user_id | Include movie in favorites of specific user 


# Install ElasticSearch at Local machine

For Ubuntu:
First of all you need instaal Java because it is a dependency of ElasticSearch
```sh
sudo apt-get install default-jdk
```
Now get package with install files
```sh
wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-5.0.0.deb
``` 
###Install the package

```sh
sudo dpkg -i elasticsearch-5.0.0.deb
```
Now run to start Elastic Search
```sh
ps -p 1
```
or 
```sh
sudo service elasticsearch start
```
For view if service is running
```sh
sudo service elasticsearch status
```
After That you can reindex catalog of movies in Elastic search with command of searchkick gem:
```sh
rails c
Movie.reindex
```
Now you can find movies with mispelling params, example:
```sh
movies = Movie.search("Mad max")
```
It is should return result with similarity of query param:

```
  {
    "id": 30,
    "title": "Mad Max: Fury Road",
    "genre": "Action",
    "rating": 4.06,
    "available_copies": 7,
    "created_at": "2023-07-08T06:43:12.370Z",
    "updated_at": "2023-07-08T06:43:12.370Z"
  }
]
```


# JWT Token - Authentication

For test you need use this endpoint in order to get Bearer Token.
```sh
curl -X POST -H 'Content-Type: application/json' -d '{"email":"user@example.com","password":"password123"}' http://localhost:3000/auth
```
After that you can call the endpoint protected with auth authentication
```sh
curl -H 'Authorization: Bearer <token>' http://localhost:3000/movies
```
You can use Postman insted of cmd curl

Access without token the resquest should return invalid token and dont allow acess in this endpoint

![Alt text](/public/auth-invalid-token.png?raw=true "Invalid Token")

For get Token you can pass informations email and password for auth, the endpoint should return bearer token. 

![Alt text](/public/auth-token.png?raw=true "Get Bearer Token")

Now you can access the endpoint with token

![Alt text](/public/auth-authenticated.png?raw=true "User Authenticated")


# Information about Pull-Requests and improvements

For more details access the link and read the description about each PR:

[PR1: Config rspec](https://github.com/rruy/movies-rental-challenge/pull/1)
[PR2: Refactor controllers and unit test](https://github.com/rruy/movies-rental-challenge/pull/2)
[PR3: Improvements test for models](https://github.com/rruy/movies-rental-challenge/pull/3)
[PR4: Refactor in Recommendations Class](https://github.com/rruy/movies-rental-challenge/pull/4)
[PR5: Install and configuration SearchKick](https://github.com/rruy/movies-rental-challenge/pull/5)
[PR6: Added infos about routes](https://github.com/rruy/movies-rental-challenge/pull/6)
[PR7: Added more tests into movie controller spec](https://github.com/rruy/movies-rental-challenge/pull/7)
[PR8: Implementation of the authentication with JWT token](https://github.com/rruy/movies-rental-challenge/pull/8)
