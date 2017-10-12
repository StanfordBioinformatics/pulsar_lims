require 'rails_helper'

RSpec.describe "data_file_types/new", type: :view do
  before(:each) do
    assign(:data_file_type, DataFileType.new(
      :user => nil,
      :name => "MyString",
      :description => "MyText"
    ))
  end

  it "renders new data_file_type form" do
    render

    assert_select "form[action=?][method=?]", data_file_types_path, "post" do

      assert_select "input#data_file_type_user_id[name=?]", "data_file_type[user_id]"

      assert_select "input#data_file_type_name[name=?]", "data_file_type[name]"

      assert_select "textarea#data_file_type_description[name=?]", "data_file_type[description]"
    end
  end
end
