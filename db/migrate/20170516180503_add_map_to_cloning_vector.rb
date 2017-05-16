class AddMapToCloningVector < ActiveRecord::Migration
  def change
    add_column :cloning_vectors, :map, :string
  end
end
