require 'rails_helper'

RSpec.describe "sequencing_results/new", type: :view do
  before(:each) do
    assign(:sequencing_result, SequencingResult.new(
      :user => nil,
      :sequencing_request => nil,
      :run_name => "MyString",
      :lane => 1,
      :comment => "MyText"
    ))
  end

  it "renders new sequencing_result form" do
    render

    assert_select "form[action=?][method=?]", sequencing_results_path, "post" do

      assert_select "input#sequencing_result_user_id[name=?]", "sequencing_result[user_id]"

      assert_select "input#sequencing_result_sequencing_request_id[name=?]", "sequencing_result[sequencing_request_id]"

      assert_select "input#sequencing_result_run_name[name=?]", "sequencing_result[run_name]"

      assert_select "input#sequencing_result_lane[name=?]", "sequencing_result[lane]"

      assert_select "textarea#sequencing_result_comment[name=?]", "sequencing_result[comment]"
    end
  end
end
