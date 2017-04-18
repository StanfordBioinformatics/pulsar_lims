require 'rails_helper'

RSpec.describe "plates/edit", type: :view do
  before(:each) do
    @plate = assign(:plate, Plate.create!(
      :user => nil,
      :name => "MyString",
      :sequencing_library_prep_kit => nil,
      :paired_end => false,
      :num_rows => 1,
      :num_cols => 1,
      :vendor => nil,
      :vendor_product_identifier => "MyString"
    ))
  end

  it "renders the edit plate form" do
    render

    assert_select "form[action=?][method=?]", plate_path(@plate), "post" do

      assert_select "input#plate_user_id[name=?]", "plate[user_id]"

      assert_select "input#plate_name[name=?]", "plate[name]"

      assert_select "input#plate_sequencing_library_prep_kit_id[name=?]", "plate[sequencing_library_prep_kit_id]"

      assert_select "input#plate_paired_end[name=?]", "plate[paired_end]"

      assert_select "input#plate_num_rows[name=?]", "plate[num_rows]"

      assert_select "input#plate_num_cols[name=?]", "plate[num_cols]"

      assert_select "input#plate_vendor_id[name=?]", "plate[vendor_id]"

      assert_select "input#plate_vendor_product_identifier[name=?]", "plate[vendor_product_identifier]"
    end
  end
end
