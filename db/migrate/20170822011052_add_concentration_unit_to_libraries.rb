class AddConcentrationUnitToLibraries < ActiveRecord::Migration
  def change
    add_reference :libraries, :concentration_unit, index: true, foreign_key: true
  end
end
