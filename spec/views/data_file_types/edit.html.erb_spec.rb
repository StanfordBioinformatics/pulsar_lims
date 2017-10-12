require 'rails_helper'

RSpec.describe "data_file_types/edit", type: :view do
  before(:each) do
    @data_file_type = assign(:data_file_type, DataFileType.create!(
      :user => nil,
      :name => "MyString",
      :description => "MyText"
    ))
  end

  it "renders the edit data_file_type form" do
    render

    assert_select "form[action=?][method=?]", data_file_type_path(@data_file_type), "post" do

      assert_select "input#data_file_type_user_id[name=?]", "data_file_type[user_id]"

      assert_select "input#data_file_type_name[name=?]", "data_file_type[name]"

      assert_select "textarea#data_file_type_description[name=?]", "data_file_type[description]"
    end
  end
end
