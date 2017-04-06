require 'rails_helper'

RSpec.describe "paired_barcodes/index", type: :view do
  before(:each) do
    assign(:paired_barcodes, [
      PairedBarcode.create!(
        :name => "Name",
        :user => nil,
        :index1 => nil,
        :index2 => nil,
        :sequencing_library_prep_kit => nil
      ),
      PairedBarcode.create!(
        :name => "Name",
        :user => nil,
        :index1 => nil,
        :index2 => nil,
        :sequencing_library_prep_kit => nil
      )
    ])
  end

  it "renders a list of paired_barcodes" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
