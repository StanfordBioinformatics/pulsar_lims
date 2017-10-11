require 'rails_helper'

RSpec.describe "file_references/show", type: :view do
  before(:each) do
    @file_reference = assign(:file_reference, FileReference.create!(
      :user => nil,
      :data_storage => nil,
      :file_path => "File Path",
      :fileid => "Fileid"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/File Path/)
    expect(rendered).to match(/Fileid/)
  end
end
