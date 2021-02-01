class AddGamePublishers < ActiveRecord::Migration[5.2]
  def change
    create_table :game_publishers do |t|
      t.integer :game_id
      t.integer :publisher_id

      t.timestamps null: false
    end
  end
end
