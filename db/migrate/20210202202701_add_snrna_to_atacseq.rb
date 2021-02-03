class AddSnrnaToAtacseq < ActiveRecord::Migration
  def change
    add_column :atacseqs, :snrna, :boolean, default: false
  end
end
