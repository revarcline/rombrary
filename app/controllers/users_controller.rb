class UsersController < ApplicationController
  # GET: /users
  get '/users' do
    erb :"/users/index" if logged_in?
    flash[:notice] = 'you must be logged in to view that page'
    redirect '/login'
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
    if params.values.include?('')
      flash[:error] = 'please fill out all fields'
      redirect '/signup'
    else
      @user = User.create(params)
      redirect "/users/#{@user.slug}"
    end
  end

  # POST: /login
  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user&.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect "/users/#{@user.slug}"
    end
    flash[:error] = 'incorrect username or password'
    redirect '/login'
  end

  # GET /logout
  get '/logout' do
    session[:user_id] = nil
    redirect '/'
  end

  # GET: /users/guy
  get '/users/:slug' do
    if logged_in?
      @user = User.find_by_slug(params[:slug])
      erb :"/users/show"
    else
      flash[:notice] = 'you must be logged in to view that page'
      redirect '/login'
    end
  end

  # GET: /users/guy/edit
  get '/users/:slug/edit' do
    erb :"/users/edit"
  end

  # PATCH: /users/guy
  patch '/users/:id' do
    redirect '/users/:id'
  end

  # DELETE: /users/guy/delete
  delete '/users/:id/delete' do
    redirect '/users'
  end
end
