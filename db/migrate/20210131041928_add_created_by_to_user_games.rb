class AddCreatedByToUserGames < ActiveRecord::Migration[5.2]
  def change
    add_column :user_games, :created_by, :boolean, default: false, null: false
  end
end
