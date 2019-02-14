require 'rails_helper'

RSpec.describe "atacseqs/new", type: :view do
  before(:each) do
    assign(:atacseq, Atacseq.new(
      :user => nil,
      :name => "MyString",
      :description => "MyText",
      :submitter_comments => "MyText",
      :notes => "MyText"
    ))
  end

  it "renders new atacseq form" do
    render

    assert_select "form[action=?][method=?]", atacseqs_path, "post" do

      assert_select "input#atacseq_user_id[name=?]", "atacseq[user_id]"

      assert_select "input#atacseq_name[name=?]", "atacseq[name]"

      assert_select "textarea#atacseq_description[name=?]", "atacseq[description]"

      assert_select "textarea#atacseq_submitter_comments[name=?]", "atacseq[submitter_comments]"

      assert_select "textarea#atacseq_notes[name=?]", "atacseq[notes]"
    end
  end
end
