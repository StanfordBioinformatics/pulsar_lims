class AddIndexInCloningVectors < ActiveRecord::Migration
  def change
		add_index :cloning_vectors, :product_url, unique: true
  end
end
