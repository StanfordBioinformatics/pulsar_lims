require 'rails_helper'

RSpec.describe "sequencing_requests/new", type: :view do
  before(:each) do
    assign(:sequencing_request, SequencingRequest.new(
      :name => "MyString",
      :comment => "MyText",
      :sequencing_platform => nil,
      :sequencing_center => nil,
      :shipped => ""
    ))
  end

  it "renders new sequencing_request form" do
    render

    assert_select "form[action=?][method=?]", sequencing_requests_path, "post" do

      assert_select "input#sequencing_request_name[name=?]", "sequencing_request[name]"

      assert_select "textarea#sequencing_request_comment[name=?]", "sequencing_request[comment]"

      assert_select "input#sequencing_request_sequencing_platform_id[name=?]", "sequencing_request[sequencing_platform_id]"

      assert_select "input#sequencing_request_sequencing_center_id[name=?]", "sequencing_request[sequencing_center_id]"

      assert_select "input#sequencing_request_shipped[name=?]", "sequencing_request[shipped]"
    end
  end
end
