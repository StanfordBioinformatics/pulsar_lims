require 'rails_helper'

RSpec.describe "sequencing_centers/new", type: :view do
  before(:each) do
    assign(:sequencing_center, SequencingCenter.new(
      :name => "MyString",
      :address => "MyText"
    ))
  end

  it "renders new sequencing_center form" do
    render

    assert_select "form[action=?][method=?]", sequencing_centers_path, "post" do

      assert_select "input#sequencing_center_name[name=?]", "sequencing_center[name]"

      assert_select "textarea#sequencing_center_address[name=?]", "sequencing_center[address]"
    end
  end
end
