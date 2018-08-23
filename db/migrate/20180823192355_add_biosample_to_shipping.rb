class AddBiosampleToShipping < ActiveRecord::Migration
  def change
    add_reference :shippings, :biosample, index: true, foreign_key: true
  end
end
