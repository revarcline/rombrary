class CreateGameRegions < ActiveRecord::Migration
  def change
    create_table :game_regions do |t|
      t.integer :game_id
      t.integer :region_id

      t.timestamps null: false
    end
  end
end
