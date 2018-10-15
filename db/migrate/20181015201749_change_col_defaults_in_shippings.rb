class ChangeColDefaultsInShippings < ActiveRecord::Migration
  def change
    change_column_default :shippings, :carrier, ""
  end
end
