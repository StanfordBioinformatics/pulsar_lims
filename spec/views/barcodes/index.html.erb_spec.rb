require 'rails_helper'

RSpec.describe "barcodes/index", type: :view do
  before(:each) do
    assign(:barcodes, [
      Barcode.create!(
        :user => nil,
        :sequencing_library_prep_kit => nil,
        :name => "Name",
        :sequence => "Sequence"
      ),
      Barcode.create!(
        :user => nil,
        :sequencing_library_prep_kit => nil,
        :name => "Name",
        :sequence => "Sequence"
      )
    ])
  end

  it "renders a list of barcodes" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Sequence".to_s, :count => 2
  end
end
