require 'rails_helper'

RSpec.describe "sequencing_library_prep_kits/show", type: :view do
  before(:each) do
    @sequencing_library_prep_kit = assign(:sequencing_library_prep_kit, SequencingLibraryPrepKit.create!(
      :user => nil,
      :name => "Name",
      :vendor => nil,
      :description => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/Name/)
    expect(rendered).to match(//)
    expect(rendered).to match(/MyText/)
  end
end
