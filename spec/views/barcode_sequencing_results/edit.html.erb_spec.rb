require 'rails_helper'

RSpec.describe "barcode_sequencing_results/edit", type: :view do
  before(:each) do
    @barcode_sequencing_result = assign(:barcode_sequencing_result, BarcodeSequencingResult.create!(
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

  it "renders the edit barcode_sequencing_result form" do
    render

    assert_select "form[action=?][method=?]", barcode_sequencing_result_path(@barcode_sequencing_result), "post" do

      assert_select "input#barcode_sequencing_result_name[name=?]", "barcode_sequencing_result[name]"

      assert_select "input#barcode_sequencing_result_sequencing_result_id[name=?]", "barcode_sequencing_result[sequencing_result_id]"

      assert_select "input#barcode_sequencing_result_library_id[name=?]", "barcode_sequencing_result[library_id]"

      assert_select "textarea#barcode_sequencing_result_comment[name=?]", "barcode_sequencing_result[comment]"

      assert_select "input#barcode_sequencing_result_read1_uri[name=?]", "barcode_sequencing_result[read1_uri]"

      assert_select "input#barcode_sequencing_result_read2_uri[name=?]", "barcode_sequencing_result[read2_uri]"

      assert_select "input#barcode_sequencing_result_read1_count[name=?]", "barcode_sequencing_result[read1_count]"

      assert_select "input#barcode_sequencing_result_read2_count[name=?]", "barcode_sequencing_result[read2_count]"
    end
  end
end
