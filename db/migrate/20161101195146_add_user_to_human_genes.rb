class AddUserToHumanGenes < ActiveRecord::Migration
  def change
    add_reference :human_genes, :user, index: true
    add_foreign_key :human_genes, :users
  end
end
