class AddGelToImmunoblots < ActiveRecord::Migration
  def change
    add_reference :immunoblots, :gel, index: true, foreign_key: true
  end
end
