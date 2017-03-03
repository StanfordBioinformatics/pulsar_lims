class AddColumnsToLibrary < ActiveRecord::Migration
  def change
    add_column :libraries, :nucleic_acid_starting_quantity, :integer
    add_column :libraries, :nucleic_acid_starting_quantity_units, :string
  end
end
