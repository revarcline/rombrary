class AdminsController < ApplicationController
  # POST: /admins
  post '/admin' do
    erb :'admin/index'
  end

  # DELETE: /admins/5/delete
  delete '/admin/delete_orphans' do
    GameGenre.where(['game_id NOT IN (?) OR genre_id NOT IN (?)',
                     Game.pluck('id'),
                     Genre.pluck('id')]).destroy_all
    redirect '/admin'
  end
end
