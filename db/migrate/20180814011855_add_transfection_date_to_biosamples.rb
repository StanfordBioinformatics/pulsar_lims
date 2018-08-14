class AddTransfectionDateToBiosamples < ActiveRecord::Migration
  def change
    add_column :biosamples, :transfection_date, :date
    add_reference :biosamples, :transfected_by, index: true
    add_foreign_key :biosamples, :users, column: :transfected_by_id
  end
end
