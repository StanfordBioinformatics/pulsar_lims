require 'rails_helper'

RSpec.describe "gel_lanes/edit", type: :view do
  before(:each) do
    @gel_lane = assign(:gel_lane, GelLane.create!(
      :lane_number => 1,
      :expected_product_size => "MyString",
      :actual_product_size => "MyString",
      :pass => false,
      :submitter_comments => "MyText",
      :notes => "MyText"
    ))
  end

  it "renders the edit gel_lane form" do
    render

    assert_select "form[action=?][method=?]", gel_lane_path(@gel_lane), "post" do

      assert_select "input#gel_lane_lane_number[name=?]", "gel_lane[lane_number]"

      assert_select "input#gel_lane_expected_product_size[name=?]", "gel_lane[expected_product_size]"

      assert_select "input#gel_lane_actual_product_size[name=?]", "gel_lane[actual_product_size]"

      assert_select "input#gel_lane_pass[name=?]", "gel_lane[pass]"

      assert_select "textarea#gel_lane_submitter_comments[name=?]", "gel_lane[submitter_comments]"

      assert_select "textarea#gel_lane_notes[name=?]", "gel_lane[notes]"
    end
  end
end
