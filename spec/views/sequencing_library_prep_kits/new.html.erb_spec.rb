require 'rails_helper'

RSpec.describe "sequencing_library_prep_kits/new", type: :view do
  before(:each) do
    assign(:sequencing_library_prep_kit, SequencingLibraryPrepKit.new(
      :user => nil,
      :name => "MyString",
      :vendor => nil,
      :description => "MyText"
    ))
  end

  it "renders new sequencing_library_prep_kit form" do
    render

    assert_select "form[action=?][method=?]", sequencing_library_prep_kits_path, "post" do

      assert_select "input#sequencing_library_prep_kit_user_id[name=?]", "sequencing_library_prep_kit[user_id]"

      assert_select "input#sequencing_library_prep_kit_name[name=?]", "sequencing_library_prep_kit[name]"

      assert_select "input#sequencing_library_prep_kit_vendor_id[name=?]", "sequencing_library_prep_kit[vendor_id]"

      assert_select "textarea#sequencing_library_prep_kit_description[name=?]", "sequencing_library_prep_kit[description]"
    end
  end
end
