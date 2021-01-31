class AddSlugsToTables < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :slug, :string
    add_column :publishers, :slug, :string
    add_column :genres, :slug, :string
    add_column :consoles, :slug, :string
    add_column :regions, :slug, :string
  end
end
