require 'rails_helper'

RSpec.describe "genome_locations/new", type: :view do
  before(:each) do
    assign(:genome_location, GenomeLocation.new(
      :name => "MyString",
      :user => nil,
      :chromosome => nil,
      :start => 1,
      :end => 1
    ))
  end

  it "renders new genome_location form" do
    render

    assert_select "form[action=?][method=?]", genome_locations_path, "post" do

      assert_select "input#genome_location_name[name=?]", "genome_location[name]"

      assert_select "input#genome_location_user_id[name=?]", "genome_location[user_id]"

      assert_select "input#genome_location_chromosome_id[name=?]", "genome_location[chromosome_id]"

      assert_select "input#genome_location_start[name=?]", "genome_location[start]"

      assert_select "input#genome_location_end[name=?]", "genome_location[end]"
    end
  end
end
