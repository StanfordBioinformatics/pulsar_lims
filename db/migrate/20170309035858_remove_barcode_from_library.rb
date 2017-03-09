class RemoveBarcodeFromLibrary < ActiveRecord::Migration
  def change
		remove_column(:libraries,:barcode)
  end
end
