class AddPropsToDonor < ActiveRecord::Migration
  def change
    add_column :donors, :age, :string
    add_column :donors, :gender, :string
  end
end
