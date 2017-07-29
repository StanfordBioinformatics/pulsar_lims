class AddFromPrototypeToBiosample < ActiveRecord::Migration
  def change
    add_reference :biosamples, :from_prototype, index: true
		add_foreign_key :biosamples, :biosamples, column: :from_prototype_id
  end
end
