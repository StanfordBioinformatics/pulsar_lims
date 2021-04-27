class IncreaseBiosampleTermNamesNameLength < ActiveRecord::Migration
  def up
    change_column :biosample_term_names, :name, :string, :limit => 100
  end

  def down
    change_column :biosample_term_names, :name, :string, :limit => 40
  end
end
