class UsersController < ApplicationController
  # GET: /users
  get '/users' do
    erb :"/users/index"
  end

  # GET: /signup
  get '/signup' do
    erb :"/users/new"
  end

  # GET /login
  get '/login' do
    erb :'/users/login'
  end

  # POST: /signup
  post '/signup' do
    redirect '/users'
  end

  # POST: /login
  post '/login' do
    @user = User.find_by(username: params[:username])
    redirect '/users/'
  end

  # GET: /users/5
  get '/users/:id' do
    @user = User.find(params[:id])
    erb :"/users/show"
  end

  # GET: /users/5/edit
  get '/users/:id/edit' do
    erb :"/users/edit"
  end

  # PATCH: /users/5
  patch '/users/:id' do
    redirect '/users/:id'
  end

  # DELETE: /users/5/delete
  delete '/users/:id/delete' do
    redirect '/users'
  end
end
