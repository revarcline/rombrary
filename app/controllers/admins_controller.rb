class AdminsController < ApplicationController
  # POST: /admins
  post '/admin' do
    erb :'admin/index'
  end

  # DELETE: /admins/5/delete
  delete '/admin/delete_orphans' do
    if current_user.admin?
      # remove orphan join table entries
      GameGenre.where(['game_id NOT IN (?) OR genre_id NOT IN (?)',
                       Game.pluck('id'),
                       Genre.pluck('id')]).destroy_all
      GameRegion.where(['game_id NOT IN (?) OR region_id NOT IN (?)',
                        Game.pluck('id'),
                        Region.pluck('id')]).destroy_all
      GamePublisher.where(['game_id NOT IN (?) OR publisher_id NOT IN (?)',
                           Game.pluck('id'),
                           Publisher.pluck('id')]).destroy_all
      UserGame.where(['game_id NOT IN (?) OR user_id NOT IN (?)',
                      Game.pluck('id'),
                      User.pluck('id')]).destroy_all
      flash[:notice] = 'orphan join entries deleted'
      redirect '/admin'
    else
      flash[:warning] = 'only an admin user may perform this action'
      redirect '/'
    end
  end
end
