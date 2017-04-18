require 'rails_helper'

RSpec.describe "wells/new", type: :view do
  before(:each) do
    assign(:well, Well.new(
      :user => nil,
      :name => "MyString",
      :plate => nil,
      :row => 1,
      :col => 1,
      :barcode => nil,
      :paired_barcode => nil,
      :fail => false,
      :comment => "MyText"
    ))
  end

  it "renders new well form" do
    render

    assert_select "form[action=?][method=?]", wells_path, "post" do

      assert_select "input#well_user_id[name=?]", "well[user_id]"

      assert_select "input#well_name[name=?]", "well[name]"

      assert_select "input#well_plate_id[name=?]", "well[plate_id]"

      assert_select "input#well_row[name=?]", "well[row]"

      assert_select "input#well_col[name=?]", "well[col]"

      assert_select "input#well_barcode_id[name=?]", "well[barcode_id]"

      assert_select "input#well_paired_barcode_id[name=?]", "well[paired_barcode_id]"

      assert_select "input#well_fail[name=?]", "well[fail]"

      assert_select "textarea#well_comment[name=?]", "well[comment]"
    end
  end
end
