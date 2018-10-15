class RemoveIndexShippingCompositeUniqueIndex < ActiveRecord::Migration
  def change
    remove_index :shippings, name: :shipping_composite_unique_index
  end
end
