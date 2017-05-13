class RemoveIndexFromChromosomes < ActiveRecord::Migration
  def change
		remove_index :chromosomes, :name
  end
end
