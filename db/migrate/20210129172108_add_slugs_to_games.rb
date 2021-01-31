class AddSlugsToGames < ActiveRecord::Migration[5.2]
  def change
    add_column :games, :slug, :string
  end
end
