require 'rails_helper'

RSpec.describe "barcodes/edit", type: :view do
  before(:each) do
    @barcode = assign(:barcode, Barcode.create!(
      :user => nil,
      :sequencing_library_prep_kit => nil,
      :name => "MyString",
      :sequence => "MyString"
    ))
  end

  it "renders the edit barcode form" do
    render

    assert_select "form[action=?][method=?]", barcode_path(@barcode), "post" do

      assert_select "input#barcode_user_id[name=?]", "barcode[user_id]"

      assert_select "input#barcode_sequencing_library_prep_kit_id[name=?]", "barcode[sequencing_library_prep_kit_id]"

      assert_select "input#barcode_name[name=?]", "barcode[name]"

      assert_select "input#barcode_sequence[name=?]", "barcode[sequence]"
    end
  end
end
