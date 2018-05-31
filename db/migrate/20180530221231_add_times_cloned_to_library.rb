class AddTimesClonedToLibrary < ActiveRecord::Migration
  def change
    add_column :libraries, :_times_cloned, :integer, default: 0
  end
end
