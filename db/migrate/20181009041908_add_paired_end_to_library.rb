class AddPairedEndToLibrary < ActiveRecord::Migration
  def change
    add_column :libraries, :paired_end, :boolean
  end
end
