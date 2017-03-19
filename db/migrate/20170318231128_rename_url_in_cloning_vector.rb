class RenameUrlInCloningVector < ActiveRecord::Migration
  def change
		rename_column :cloning_vectors, :url, :product_url
  end
end
