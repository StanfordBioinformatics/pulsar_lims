require 'rails_helper'

RSpec.describe "data_file_types/show", type: :view do
  before(:each) do
    @data_file_type = assign(:data_file_type, DataFileType.create!(
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
