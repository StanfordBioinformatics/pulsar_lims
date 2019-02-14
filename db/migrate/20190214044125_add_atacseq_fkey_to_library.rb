class AddAtacseqFkeyToLibrary < ActiveRecord::Migration
  def change
    add_reference :libraries, :atacseq, index: true, foreign_key: true
  end
end
