require 'rails_helper'

RSpec.describe "library_fragmentation_methods/new", type: :view do
  before(:each) do
    assign(:library_fragmentation_method, LibraryFragmentationMethod.new(
      :user => nil,
      :name => "MyString",
      :description => "MyText"
    ))
  end

  it "renders new library_fragmentation_method form" do
    render

    assert_select "form[action=?][method=?]", library_fragmentation_methods_path, "post" do

      assert_select "input#library_fragmentation_method_user_id[name=?]", "library_fragmentation_method[user_id]"

      assert_select "input#library_fragmentation_method_name[name=?]", "library_fragmentation_method[name]"

      assert_select "textarea#library_fragmentation_method_description[name=?]", "library_fragmentation_method[description]"
    end
  end
end
