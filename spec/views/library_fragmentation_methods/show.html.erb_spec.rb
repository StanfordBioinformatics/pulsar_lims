require 'rails_helper'

RSpec.describe "library_fragmentation_methods/show", type: :view do
  before(:each) do
    @library_fragmentation_method = assign(:library_fragmentation_method, LibraryFragmentationMethod.create!(
      :user => nil,
      :name => "Name",
      :description => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/MyText/)
  end
end
