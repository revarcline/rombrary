class AdminController < ApplicationController
  # GET: /admin
  get '/admin' do
    if current_user.admin?
      erb :'admin/index'
    else
      flash[:warning] = 'only an admin user may perform this action'
      redirect '/'
    end
  end

  # DELETE: /admin/delete_params
  delete '/admin/delete_params' do
    if current_user.admin?
      Console.where(id: params[:consoles]).destroy_all
      Genre.where(id: params[:genres]).destroy_all
      Region.where(id: params[:regions]).destroy_all
      Publisher.where(id: params[:publishers]).destroy_all
      flash[:notice] = 'all items deleted successfully'
      redirect '/admin'
    else
      flash[:warning] = 'only an admin user may perform this action'
      redirect '/'
    end
  end

  # DELETE: /admin/delete_orphans
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
