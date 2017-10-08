require 'rails_helper'

RSpec.describe "data_storage_providers/edit", type: :view do
  before(:each) do
    @data_storage_provider = assign(:data_storage_provider, DataStorageProvider.create!(
      :user => nil,
      :name => "MyString"
    ))
  end

  it "renders the edit data_storage_provider form" do
    render

    assert_select "form[action=?][method=?]", data_storage_provider_path(@data_storage_provider), "post" do

      assert_select "input#data_storage_provider_user_id[name=?]", "data_storage_provider[user_id]"

      assert_select "input#data_storage_provider_name[name=?]", "data_storage_provider[name]"
    end
  end
end
