class ChangeTrackingCodeDefaultInShippings < ActiveRecord::Migration
  def change
    change_column_default :shippings, :tracking_code, ""
    change_column_default :shippings, :received, false 
  end
end
