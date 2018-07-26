require 'rails_helper'

RSpec.describe "gel_lanes/new", type: :view do
  before(:each) do
    assign(:gel_lane, GelLane.new(
      :lane_number => 1,
      :expected_product_size => "MyString",
      :actual_product_size => "MyString",
      :pass => false,
      :submitter_comments => "MyText",
      :notes => "MyText"
    ))
  end

  it "renders new gel_lane form" do
    render

    assert_select "form[action=?][method=?]", gel_lanes_path, "post" do

      assert_select "input#gel_lane_lane_number[name=?]", "gel_lane[lane_number]"

      assert_select "input#gel_lane_expected_product_size[name=?]", "gel_lane[expected_product_size]"

      assert_select "input#gel_lane_actual_product_size[name=?]", "gel_lane[actual_product_size]"

      assert_select "input#gel_lane_pass[name=?]", "gel_lane[pass]"

      assert_select "textarea#gel_lane_submitter_comments[name=?]", "gel_lane[submitter_comments]"

      assert_select "textarea#gel_lane_notes[name=?]", "gel_lane[notes]"
    end
  end
end
