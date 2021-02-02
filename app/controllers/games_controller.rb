class GamesController < ApplicationController
  # GET: /games
  get '/games' do
    erb :"/games/index"
  end

  # GET: /games/new
  get '/games/new' do
    if logged_in?
      erb :"/games/new"
    else
      flash[:notice] = 'you must be logged in to view that page'
      redirect '/login'
    end
  end

  # POST: /games
  post '/games' do
    if logged_in?
      # add new console to console params
      if params[:console][:name] != '' && params[:game][:console] == ''
        @console = Console.create(params[:console])
        params[:game][:console] = @console
      elsif params[:game][:console] != ''
        params[:game][:console] = Console.find(params[:game][:console])
      end

      # remap params
      params[:game][:genres] = params[:game][:genres].map { |id| Genre.find(id) }
      params[:game][:publishers] = params[:game][:publishers].map { |id| Publisher.find(id) }
      params[:game][:regions] = params[:game][:regions].map { |id| Region.find(id) }

      # add new item to other params
      unless params[:genre][:name] == ''
        @genre = Genre.create(params[:genre])
        params[:game][:genres] << @genre
      end

      unless params[:publisher][:name] == ''
        @publisher = Publisher.create(params[:publisher])
        params[:game][:publishers] << @publisher
      end

      unless params[:region][:name] == ''
        @region = Region.create(params[:region])
        params[:game][:regions] << @regions
      end

      if params[:game][:name] == '' || params[:game][:year] == '' || params[:game][:console] == ''
        flash[:notice] = 'please fill out required fields'
        redirect '/games/new'
      end

      @game = Game.create(params[:game])

      current_user.games << @game
      current_user.save
      @game.created_by = current_user
      redirect "/games/#{@game.id}"
    else
      flash[:notice] = 'you must be logged in to create a new game'
      redirect '/login'
    end
  end

  # GET: /games/by/genre/fighting
  get '/games/by/:attr/:slug' do
    @slug = params[:slug]
    @attr = params[:attr]
    @obj = nil
    @gamelist = nil
    case @attr
    when 'genre'
      @obj = Genre.find_by_slug(@slug)
    when 'region'
      @obj = Region.find_by_slug(@slug)
    when 'console'
      @obj = Console.find_by_slug(@slug)
    when 'publisher'
      @obj = Publisher.find_by_slug(@slug)
    end
    @gamelist = @obj.games
    erb :'/games/show_attr'
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

  # GET: /games/5
  get '/games/:id' do
    @game = Game.find(params[:id])
    erb :"/games/show"
  end

  # GET: /games/5/edit
  get '/games/:id/edit' do
    erb :"/games/edit.html"
  end

  # PATCH: /games/5
  patch '/games/:id' do
    redirect '/games/:id'
  end

  # DELETE: /games/5/delete
  delete '/games/:id/delete' do
    redirect '/games'
  end
end
