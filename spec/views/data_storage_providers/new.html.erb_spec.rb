require 'rails_helper'

RSpec.describe "data_storage_providers/new", type: :view do
  before(:each) do
    assign(:data_storage_provider, DataStorageProvider.new(
      :user => nil,
      :name => "MyString"
    ))
  end

  it "renders new data_storage_provider form" do
    render

    assert_select "form[action=?][method=?]", data_storage_providers_path, "post" do

      assert_select "input#data_storage_provider_user_id[name=?]", "data_storage_provider[user_id]"

      assert_select "input#data_storage_provider_name[name=?]", "data_storage_provider[name]"
    end
  end
end
