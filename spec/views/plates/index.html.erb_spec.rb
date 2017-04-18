require 'rails_helper'

RSpec.describe "plates/index", type: :view do
  before(:each) do
    assign(:plates, [
      Plate.create!(
        :user => nil,
        :name => "Name",
        :sequencing_library_prep_kit => nil,
        :paired_end => false,
        :num_rows => 2,
        :num_cols => 3,
        :vendor => nil,
        :vendor_product_identifier => "Vendor Product Identifier"
      ),
      Plate.create!(
        :user => nil,
        :name => "Name",
        :sequencing_library_prep_kit => nil,
        :paired_end => false,
        :num_rows => 2,
        :num_cols => 3,
        :vendor => nil,
        :vendor_product_identifier => "Vendor Product Identifier"
      )
    ])
  end

  it "renders a list of plates" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Vendor Product Identifier".to_s, :count => 2
  end
end
