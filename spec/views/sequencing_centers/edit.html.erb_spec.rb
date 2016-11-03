require 'rails_helper'

RSpec.describe "sequencing_centers/edit", type: :view do
  before(:each) do
    @sequencing_center = assign(:sequencing_center, SequencingCenter.create!(
      :name => "MyString",
      :address => "MyText"
    ))
  end

  it "renders the edit sequencing_center form" do
    render

    assert_select "form[action=?][method=?]", sequencing_center_path(@sequencing_center), "post" do

      assert_select "input#sequencing_center_name[name=?]", "sequencing_center[name]"

      assert_select "textarea#sequencing_center_address[name=?]", "sequencing_center[address]"
    end
  end
end
