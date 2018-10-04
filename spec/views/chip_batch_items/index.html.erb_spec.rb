require 'rails_helper'

RSpec.describe "chip_batch_items/index", type: :view do
  before(:each) do
    assign(:chip_batch_items, [
      ChipBatchItem.create!(
        :user => nil,
        :chip_batch => nil,
        :biosample => nil,
        :concentration => "Concentration",
        :notes => "MyText"
      ),
      ChipBatchItem.create!(
        :user => nil,
        :chip_batch => nil,
        :biosample => nil,
        :concentration => "Concentration",
        :notes => "MyText"
      )
    ])
  end

  it "renders a list of chip_batch_items" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Concentration".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
