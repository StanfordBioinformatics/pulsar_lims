require 'rails_helper'

RSpec.describe "library_sequencing_results/new", type: :view do
  before(:each) do
    assign(:library_sequencing_result, LibrarySequencingResult.new(
      :name => "MyString",
      :sequencing_result => nil,
      :library => nil,
      :comment => "MyText",
      :read1_uri => "MyString",
      :read2_uri => "MyString",
      :read1_count => 1,
      :read2_count => 1
    ))
  end

  it "renders new library_sequencing_result form" do
    render

    assert_select "form[action=?][method=?]", library_sequencing_results_path, "post" do

      assert_select "input#library_sequencing_result_name[name=?]", "library_sequencing_result[name]"

      assert_select "input#library_sequencing_result_sequencing_result_id[name=?]", "library_sequencing_result[sequencing_result_id]"

      assert_select "input#library_sequencing_result_library_id[name=?]", "library_sequencing_result[library_id]"

      assert_select "textarea#library_sequencing_result_comment[name=?]", "library_sequencing_result[comment]"

      assert_select "input#library_sequencing_result_read1_uri[name=?]", "library_sequencing_result[read1_uri]"

      assert_select "input#library_sequencing_result_read2_uri[name=?]", "library_sequencing_result[read2_uri]"

      assert_select "input#library_sequencing_result_read1_count[name=?]", "library_sequencing_result[read1_count]"

      assert_select "input#library_sequencing_result_read2_count[name=?]", "library_sequencing_result[read2_count]"
    end
  end
end
