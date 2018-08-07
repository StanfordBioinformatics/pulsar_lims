class AddConcentrationToAntibody < ActiveRecord::Migration
  def change
    add_column :antibodies, :concentration, :string
    add_reference :antibodies, :concentration_units, index: true
    add_foreign_key :antibodies, :units, column: :concentration_units_id
  end
end
