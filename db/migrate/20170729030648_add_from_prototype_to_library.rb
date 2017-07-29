class AddFromPrototypeToLibrary < ActiveRecord::Migration
  def change
    add_reference :libraries, :from_prototype, index: true
		add_foreign_key :libraries, :libraries, column: :from_prototype_id
  end
end
