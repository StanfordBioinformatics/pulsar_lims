class RemoveCrosslinkingMethodFromLibraries < ActiveRecord::Migration
  def change
    remove_column :libraries, :crosslinking_method, :string
  end
end
