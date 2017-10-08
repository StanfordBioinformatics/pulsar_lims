require 'rails_helper'

RSpec.describe "data_storage_providers/show", type: :view do
  before(:each) do
    @data_storage_provider = assign(:data_storage_provider, DataStorageProvider.create!(
      :user => nil,
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/Name/)
  end
end
