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
    elsif User.find_by(username: params[:username])
      flash[:error] = 'username is already taken'
      redirect '/signup'
    elsif User.find_by(email: params[:email])
      flash[:error] = 'email is already taken'
      redirect '/signup'
    elsif params[:password] != params[:password_confirmation]
      flash[:error] = 'password confirmation does not match'
      redirect '/signup'
    else
      @user = User.create(params)
      session[:user_id] = @user.id
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
    @user = User.find_by_slug(params[:slug])
    if @user == current_user || current_user.admin?
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
    if @user == current_user || current_user.admin?
      if !@user.authenticate(params[:old_password]) || !current_user.admin?
        flash[:error] = 'current password is wrong'
        redirect "/users/#{@user.slug}/edit"
      elsif params[:user][:email] == '' || params[:old_password] == ''
        flash[:error] = 'please fill out all required fields'
        redirect "/users/#{@user.slug}/edit"
      elsif User.find_by(email: params[:user][:email]) && params[:user][:email] != @user.email
        flash[:error] = 'email is already taken'
        redirect "/users/#{@user.slug}/edit"
      elsif params[:user][:password] != params[:user][:password_confirmation]
        flash[:error] = 'password confirmation does not match'
        redirect "/users/#{@user.slug}/edit"
      elsif params[:user][:password] == '' && params[:user][:password_confirmation] == ''
        @user.update(email: params[:user][:email])
        redirect "/users/#{params[:slug]}"
      else
        @user.update(params[:user])
        redirect "/users/#{params[:slug]}"
      end
    elsif logged_in?
      flash[:notice] = "you must be logged in as #{@user.username} to do that"
      redirect "/users/#{current_user.slug}"
    else
      flash[:notice] = 'you must be logged in to view that page'
      redirect '/login'
    end
  end

  # GET: /users/guy/delete
  get '/users/:slug/delete' do
    @user = User.find_by_slug(params[:slug])
    if current_user == @user || current_user.admin?
      erb :'/users/delete'
    elsif logged_in?
      flash[:warning] = "must be logged in as #{@user.username} to delete #{@user.username}"
      redirect "/users/#{current_user.slug}"
    else
      flash[:notice] = 'you must be logged in to view that page'
      redirect '/login'
    end
  end

  # DELETE: /users/guy
  delete '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    if current_user == @user || current_user.admin?
      @user.delete
      redirect '/'
    elsif logged_in?
      flash[:warning] = "must be logged in as #{@user.username} to delete #{@user.username}"
      redirect "/users/#{current_user.slug}"
    else
      flash[:notice] = 'you must be logged in to view that page'
      redirect '/login'
    end
  end

  # GET /users/guy/add/4
  get '/users/:slug/add/:id' do
    @user = User.find_by_slug(params[:slug])
    # can add game to own logged in account
    if current_user == @user || current_user.admin?
      @game = Game.find(params[:id])
      erb :'/users/add'
    # redirect wrong user
    elsif logged_in?
      flash[:notice] = "you must be logged in as #{@user.username} to do that"
      redirect "/users/#{current_user.slug}"
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
    if current_user == @user || current_user.admin?
      @game = Game.find(params[:id])
      erb :'/users/remove'
    # wrong user redirected
    elsif logged_in?
      flash[:notice] = "you must be logged in as #{@user.username} to do that"
      redirect "/users/#{current_user.slug}"
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
      @user.games.destroy(@game)
      # pass created_by to next user with game or delete orphan
      if (ug = UserGame.where(game: @game)) != []
        ug[0].update(created_by: true)
      else
        @game.destroy
      end
      redirect "/users/#{@user.slug}"
    elsif current_user == @user && !current_user.games.include?(@game)
      flash[:notice] = "#{@user.username} doesn't own #{@game.name}"
      redirect "/users/#{@user.slug}"
    elsif current_user != @user && logged_in?
      flash[:notice] = "you must be logged in as #{@user.username} to do that"
      redirect "/users/#{current_user.slug}"
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
      redirect "/users/#{current_user.slug}"
    # logged out sent to login
    else
      flash[:notice] = 'you must be logged in to view that page'
      redirect '/login'
    end
  end
end
