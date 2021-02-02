class AddMultiomeToAtacseq < ActiveRecord::Migration
  def change
    add_column :atacseqs, :multiome, :boolean, default: false
  end
end
