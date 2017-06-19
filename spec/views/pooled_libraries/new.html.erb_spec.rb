require 'rails_helper'

RSpec.describe "pooled_libraries/new", type: :view do
  before(:each) do
    assign(:pooled_library, PooledLibrary.new(
      :name => "MyString",
      :user => nil,
      :paired_end => false,
      :sequencing_library_prep_kit => nil,
      :size_range => "MyString"
    ))
  end

  it "renders new pooled_library form" do
    render

    assert_select "form[action=?][method=?]", pooled_libraries_path, "post" do

      assert_select "input#pooled_library_name[name=?]", "pooled_library[name]"

      assert_select "input#pooled_library_user_id[name=?]", "pooled_library[user_id]"

      assert_select "input#pooled_library_paired_end[name=?]", "pooled_library[paired_end]"

      assert_select "input#pooled_library_sequencing_library_prep_kit_id[name=?]", "pooled_library[sequencing_library_prep_kit_id]"

      assert_select "input#pooled_library_size_range[name=?]", "pooled_library[size_range]"
    end
  end
end
