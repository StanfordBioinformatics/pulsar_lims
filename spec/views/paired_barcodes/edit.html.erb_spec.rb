require 'rails_helper'

RSpec.describe "paired_barcodes/edit", type: :view do
  before(:each) do
    @paired_barcode = assign(:paired_barcode, PairedBarcode.create!(
      :name => "MyString",
      :user => nil,
      :index1 => nil,
      :index2 => nil,
      :sequencing_library_prep_kit => nil
    ))
  end

  it "renders the edit paired_barcode form" do
    render

    assert_select "form[action=?][method=?]", paired_barcode_path(@paired_barcode), "post" do

      assert_select "input#paired_barcode_name[name=?]", "paired_barcode[name]"

      assert_select "input#paired_barcode_user_id[name=?]", "paired_barcode[user_id]"

      assert_select "input#paired_barcode_index1_id[name=?]", "paired_barcode[index1_id]"

      assert_select "input#paired_barcode_index2_id[name=?]", "paired_barcode[index2_id]"

      assert_select "input#paired_barcode_sequencing_library_prep_kit_id[name=?]", "paired_barcode[sequencing_library_prep_kit_id]"
    end
  end
end
