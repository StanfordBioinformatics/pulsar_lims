require 'rails_helper'

RSpec.describe "gel_lanes/show", type: :view do
  before(:each) do
    @gel_lane = assign(:gel_lane, GelLane.create!(
      :lane_number => 2,
      :expected_product_size => "Expected Product Size",
      :actual_product_size => "Actual Product Size",
      :pass => false,
      :submitter_comments => "MyText",
      :notes => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Expected Product Size/)
    expect(rendered).to match(/Actual Product Size/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/MyText/)
  end
end
