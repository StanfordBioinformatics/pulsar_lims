class AddShippingToDonorConstruct < ActiveRecord::Migration
  def change
   add_reference :donor_constructs, :sent_to
   add_foreign_key :donor_constructs, :addresses, column: :sent_to_id
   add_column :donor_constructs, :date_sent, :date
  end
end
