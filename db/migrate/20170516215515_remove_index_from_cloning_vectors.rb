class RemoveIndexFromCloningVectors < ActiveRecord::Migration
  def change
		remove_index :cloning_vectors, :product_url
  end
end
