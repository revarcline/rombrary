class UsersController < ApplicationController
  # GET: /users
  get '/users' do
    if logged_in?
      erb :"/users/index"
    else
      flash[:notice] = 'you must be logged in to view that page'
      redirect '/login'
    end
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

  # GET /games/by/genre
  get '/games/by/:attr' do
    @attr = params[:attr]
    case @attr
    when 'genre'
      @list = Genre.all
    when 'region'
      @list = Region.all
    when 'console'
      @list = Console.all
    when 'publisher'
      @list = Publisher.all
    end
    erb :'/games/index_attr'
  end

  # GET: /users/guy/edit
  get '/users/:slug/edit' do
    @user = User.find_by_slug(params[:slug])
    if @user == current_user
      erb :"/users/edit"
    elsif logged_in?
      flash[:notice] = "you must be logged in as #{@user.username} to do that"
      redirect '/'
    else
      flash[:notice] = 'you must be logged in to view that page'
      redirect '/login'
    end
  end

  # PATCH: /users/guy
  patch '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    # placeholder for updating user
    redirect "/users/#{@user.slug}"
  end

  # GET: /users/guy/delete
  get '/users/:slug/delete' do
    @user = User.find_by_slug(params[:slug])
    if current_user == @user
      erb :'/users/delete'
    else
      flash[:warning] = "must be logged in as #{@user.username} to delete #{@user.username}"
      redirect '/login'
    end
  end

  # DELETE: /users/guy
  delete '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    if current_user == @user
      @user.delete
      redirect '/'
    else
      flash[:warning] = "must be logged in as #{@user.username} to delete #{@user.username}"
      redirect '/login'
    end
  end

  # GET /users/guy/add/4
  get '/users/:slug/add/:id' do
    @user = User.find_by_slug(params[:slug])
    # can add game to own logged in account
    if current_user == @user
      @game = Game.find(params[:id])
      erb :'/users/add'
    # redirect wrong user
    elsif logged_in?
      flash[:notice] = "you must be logged in as #{@user.username} to do that"
      redirect '/'
    # logged out user go away
    else
      flash[:notice] = 'you must be logged in to view that page'
      redirect '/login'
    end
  end

  # GET /users/guy/remove/4
  get '/users/:slug/remove/:id' do
    @user = User.find_by_slug(params[:slug])
    # only allow logged in user to remove game from library
    if current_user == @user
      @game = Game.find(params[:id])
      erb :'/users/remove'
    # wrong user redirected
    elsif logged_in?
      flash[:notice] = "you must be logged in as #{@user.username} to do that"
      redirect '/'
    # logged out sent to login
    else
      flash[:notice] = 'you must be logged in to view that page'
      redirect '/login'
    end
  end

  # POST /users/guy/4
  post '/users/:slug/:id' do
    @user = User.find_by_slug(params[:slug])
    @game = Game.find(params[:id])
    # add game to user games if correct user
    if current_user == @user && !current_user.games.include?(@game)
      @user.games << @game
      @user.save
      redirect "/users/#{@user.slug}"
    # avoid duplication
    elsif current_user == @user && current_user.games.include?(@game)
      flash[:notice] = "#{@user.username} already owns #{@game.name}"
      redirect "/users/#{@user.slug}"
    # redirect wrong user
    elsif current_user != @user && logged_in?
      flash[:notice] = "you must be logged in as #{@user.username} to do that"
      redirect '/'
    # logged out sent to login
    else
      flash[:notice] = 'you must be logged in to view that page'
      redirect '/login'
    end
  end

  # DELETE /users/guy/4
  delete '/users/:slug/:id' do
    @user = User.find_by_slug(params[:slug])
    @game = Game.find(params[:id])
    if current_user == @user && current_user.games.include?(@game)
      @user.games.delete(@game)
      @user.save
      redirect "/users/#{@user.slug}"
    elsif current_user == @user && !current_user.games.include?(@game)
      flash[:notice] = "#{@user.username} doesn't own #{@game.name}"
      redirect "/users/#{@user.slug}"
    elsif current_user != @user && logged_in?
      flash[:notice] = "you must be logged in as #{@user.username} to do that"
      redirect '/'
    else
      flash[:notice] = 'you must be logged in to view that page'
      redirect '/login'
    end
  end
end
