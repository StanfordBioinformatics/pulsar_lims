class AddIndexNumberToBarcodes < ActiveRecord::Migration
  def change
    add_column :barcodes, :index_number, :integer
  end
end
