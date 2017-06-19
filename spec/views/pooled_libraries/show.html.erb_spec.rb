require 'rails_helper'

RSpec.describe "pooled_libraries/show", type: :view do
  before(:each) do
    @pooled_library = assign(:pooled_library, PooledLibrary.create!(
      :name => "Name",
      :user => nil,
      :paired_end => false,
      :sequencing_library_prep_kit => nil,
      :size_range => "Size Range"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(//)
    expect(rendered).to match(/false/)
    expect(rendered).to match(//)
    expect(rendered).to match(/Size Range/)
  end
end
