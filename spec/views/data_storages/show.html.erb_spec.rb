require 'rails_helper'

RSpec.describe "data_storages/show", type: :view do
  before(:each) do
    @data_storage = assign(:data_storage, DataStorage.create!(
      :user => nil,
      :name => "Name",
      :bucket => "Bucket",
      :project_identifier => "Project Identifier",
      :folder_base_path => "Folder Base Path"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Bucket/)
    expect(rendered).to match(/Project Identifier/)
    expect(rendered).to match(/Folder Base Path/)
  end
end
