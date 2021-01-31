class AddCreatedByToGames < ActiveRecord::Migration[5.2]
  def change
    add_column :games, :created_by, :integer, null: false
  end
end
