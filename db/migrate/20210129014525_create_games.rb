class CreateGames < ActiveRecord::Migration[5.2]
  def change
    create_table :games do |t|
      t.string :name
      t.integer :console_id
      t.integer :publisher_id

      t.timestamps null: false
    end
  end
end
