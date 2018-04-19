class AddStartingAmountToBiosample < ActiveRecord::Migration
  def change
    add_column :biosamples, :starting_amount, :string
    add_column :biosamples, :starting_amount_units, :string
  end
end
