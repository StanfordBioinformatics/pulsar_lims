class AddCrosslinkingMethodToLibraries < ActiveRecord::Migration
  def change
    add_column :libraries, :crosslinking_method, :string
  end
end
