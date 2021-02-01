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

  # GET: /games/genre/fighting
  get '/games/by/:attr/:slug' do
    @slug = params[:slug]
    @attr = params[:attr]
    @obj = nil
    @gamelist = nil
    case @attr
    when 'genre'
      @obj = Genre.find_by_slug(@slug)
      @gamelist = Game.joins(:game_genres).where(game_genres: { genre_id: @obj.id })
    when 'region'
      @obj = Region.find_by_slug(@slug)
      @gamelist = Game.joins(:game_regions).where(game_regions: { region: @obj.id })
    when 'console'
      @obj = Console.find_by_slug(@slug)
      @gamelist = Game.where(console_id: @obj.id)
    when 'publisher'
      @obj = Publisher.find_by_slug(@slug)
      @gamelist = Game.joins(:game_publishers).where(game_publishers: { publisher: @obj.id })
    end
    erb :'/games/show_attr'
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
