class AddTissueToBiosampleTypes < ActiveRecord::Migration
  def change
    add_column :biosample_types, :tissue, :boolean, default: false
  end
end
