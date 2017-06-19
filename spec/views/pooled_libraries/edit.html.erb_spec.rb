require 'rails_helper'

RSpec.describe "pooled_libraries/edit", type: :view do
  before(:each) do
    @pooled_library = assign(:pooled_library, PooledLibrary.create!(
      :name => "MyString",
      :user => nil,
      :paired_end => false,
      :sequencing_library_prep_kit => nil,
      :size_range => "MyString"
    ))
  end

  it "renders the edit pooled_library form" do
    render

    assert_select "form[action=?][method=?]", pooled_library_path(@pooled_library), "post" do

      assert_select "input#pooled_library_name[name=?]", "pooled_library[name]"

      assert_select "input#pooled_library_user_id[name=?]", "pooled_library[user_id]"

      assert_select "input#pooled_library_paired_end[name=?]", "pooled_library[paired_end]"

      assert_select "input#pooled_library_sequencing_library_prep_kit_id[name=?]", "pooled_library[sequencing_library_prep_kit_id]"

      assert_select "input#pooled_library_size_range[name=?]", "pooled_library[size_range]"
    end
  end
end
