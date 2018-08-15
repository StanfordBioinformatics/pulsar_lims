class AddWildTypeToBiosamples < ActiveRecord::Migration
  def change
    add_column :biosamples, :wild_type, :boolean, default: false
  end
end
