require 'rails_helper'

RSpec.describe "single_cell_sortings/index", type: :view do
  before(:each) do
    assign(:single_cell_sortings, [
      SingleCellSorting.create!(
        :user => nil,
        :name => "Name",
        :description => "MyText"
      ),
      SingleCellSorting.create!(
        :user => nil,
        :name => "Name",
        :description => "MyText"
      )
    ])
  end

  it "renders a list of single_cell_sortings" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
