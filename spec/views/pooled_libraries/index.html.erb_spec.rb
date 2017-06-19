require 'rails_helper'

RSpec.describe "pooled_libraries/index", type: :view do
  before(:each) do
    assign(:pooled_libraries, [
      PooledLibrary.create!(
        :name => "Name",
        :user => nil,
        :paired_end => false,
        :sequencing_library_prep_kit => nil,
        :size_range => "Size Range"
      ),
      PooledLibrary.create!(
        :name => "Name",
        :user => nil,
        :paired_end => false,
        :sequencing_library_prep_kit => nil,
        :size_range => "Size Range"
      )
    ])
  end

  it "renders a list of pooled_libraries" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Size Range".to_s, :count => 2
  end
end
