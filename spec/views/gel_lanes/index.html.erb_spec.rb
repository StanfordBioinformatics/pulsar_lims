require 'rails_helper'

RSpec.describe "gel_lanes/index", type: :view do
  before(:each) do
    assign(:gel_lanes, [
      GelLane.create!(
        :lane_number => 2,
        :expected_product_size => "Expected Product Size",
        :actual_product_size => "Actual Product Size",
        :pass => false,
        :submitter_comments => "MyText",
        :notes => "MyText"
      ),
      GelLane.create!(
        :lane_number => 2,
        :expected_product_size => "Expected Product Size",
        :actual_product_size => "Actual Product Size",
        :pass => false,
        :submitter_comments => "MyText",
        :notes => "MyText"
      )
    ])
  end

  it "renders a list of gel_lanes" do
    render
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Expected Product Size".to_s, :count => 2
    assert_select "tr>td", :text => "Actual Product Size".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
