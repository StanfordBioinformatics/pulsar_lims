class AddGelToPcrs < ActiveRecord::Migration
  def change
    add_reference :pcrs, :gel, index: true, foreign_key: true
  end
end
