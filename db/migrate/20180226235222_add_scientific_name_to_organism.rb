class AddScientificNameToOrganism < ActiveRecord::Migration
  def change
    add_column :organisms, :scientific_name, :string, index: true
  end
end
