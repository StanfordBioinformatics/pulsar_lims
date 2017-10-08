require 'rails_helper'

RSpec.describe "data_storages/index", type: :view do
  before(:each) do
    assign(:data_storages, [
      DataStorage.create!(
        :user => nil,
        :name => "Name",
        :bucket => "Bucket",
        :project_identifier => "Project Identifier",
        :folder_base_path => "Folder Base Path"
      ),
      DataStorage.create!(
        :user => nil,
        :name => "Name",
        :bucket => "Bucket",
        :project_identifier => "Project Identifier",
        :folder_base_path => "Folder Base Path"
      )
    ])
  end

  it "renders a list of data_storages" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Bucket".to_s, :count => 2
    assert_select "tr>td", :text => "Project Identifier".to_s, :count => 2
    assert_select "tr>td", :text => "Folder Base Path".to_s, :count => 2
  end
end
