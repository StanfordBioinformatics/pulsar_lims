require 'rails_helper'

RSpec.describe "data_storage_providers/index", type: :view do
  before(:each) do
    assign(:data_storage_providers, [
      DataStorageProvider.create!(
        :user => nil,
        :name => "Name"
      ),
      DataStorageProvider.create!(
        :user => nil,
        :name => "Name"
      )
    ])
  end

  it "renders a list of data_storage_providers" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
