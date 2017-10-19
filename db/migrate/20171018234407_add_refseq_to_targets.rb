class AddRefseqToTargets < ActiveRecord::Migration
  def change
    add_column :targets, :refseq, :string, unique: true
  end
end
