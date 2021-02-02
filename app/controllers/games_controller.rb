class GamesController < ApplicationController
  # GET: /games
  get '/games' do
    erb :"/games/index"
  end

  # GET: /games/new
  get '/games/new' do
    erb :"/games/new"
  end

  # POST: /games
  post '/games' do
    redirect '/games'
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
