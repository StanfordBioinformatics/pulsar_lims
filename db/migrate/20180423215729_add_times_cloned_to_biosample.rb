class AddTimesClonedToBiosample < ActiveRecord::Migration
  def change
    add_column :biosamples, :times_cloned, :integer, default: 0
  end
end
