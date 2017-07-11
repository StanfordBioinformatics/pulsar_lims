class AddPrototypeToLibrary < ActiveRecord::Migration
  def change
    add_column :libraries, :prototype, :boolean, default: false
  end
end
