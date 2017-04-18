require 'rails_helper'

RSpec.describe "wells/edit", type: :view do
  before(:each) do
    @well = assign(:well, Well.create!(
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

  it "renders the edit well form" do
    render

    assert_select "form[action=?][method=?]", well_path(@well), "post" do

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
