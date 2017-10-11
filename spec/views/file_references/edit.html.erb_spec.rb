require 'rails_helper'

RSpec.describe "file_references/edit", type: :view do
  before(:each) do
    @file_reference = assign(:file_reference, FileReference.create!(
      :user => nil,
      :data_storage => nil,
      :file_path => "MyString",
      :fileid => "MyString"
    ))
  end

  it "renders the edit file_reference form" do
    render

    assert_select "form[action=?][method=?]", file_reference_path(@file_reference), "post" do

      assert_select "input#file_reference_user_id[name=?]", "file_reference[user_id]"

      assert_select "input#file_reference_data_storage_id[name=?]", "file_reference[data_storage_id]"

      assert_select "input#file_reference_file_path[name=?]", "file_reference[file_path]"

      assert_select "input#file_reference_fileid[name=?]", "file_reference[fileid]"
    end
  end
end
