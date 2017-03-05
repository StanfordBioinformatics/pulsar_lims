class AddLibFragMethodToLibrary < ActiveRecord::Migration
  def change
    add_reference :libraries, :library_fragmentation_method, index: true, foreign_key: true
  end
end
