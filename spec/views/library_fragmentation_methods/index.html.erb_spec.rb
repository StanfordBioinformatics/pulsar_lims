require 'rails_helper'

RSpec.describe "library_fragmentation_methods/index", type: :view do
  before(:each) do
    assign(:library_fragmentation_methods, [
      LibraryFragmentationMethod.create!(
        :user => nil,
        :name => "Name",
        :description => "MyText"
      ),
      LibraryFragmentationMethod.create!(
        :user => nil,
        :name => "Name",
        :description => "MyText"
      )
    ])
  end

  it "renders a list of library_fragmentation_methods" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
