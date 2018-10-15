class AddCompositeIndexOnShippings < ActiveRecord::Migration
  def change
    add_index(:shippings, [:biosample_id, :carrier, :date_shipped, :from_id, :to_id,  :received, :tracking_code], unique: true, name: :shipping_composite_unique_index)
  end
end
