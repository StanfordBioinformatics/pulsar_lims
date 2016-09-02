class AddNameToAntibody < ActiveRecord::Migration
  def change
    add_column :antibodies, :name, :string, index: true
  end
end
