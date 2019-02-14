require 'rails_helper'

RSpec.describe "atacseqs/edit", type: :view do
  before(:each) do
    @atacseq = assign(:atacseq, Atacseq.create!(
      :user => nil,
      :name => "MyString",
      :description => "MyText",
      :submitter_comments => "MyText",
      :notes => "MyText"
    ))
  end

  it "renders the edit atacseq form" do
    render

    assert_select "form[action=?][method=?]", atacseq_path(@atacseq), "post" do

      assert_select "input#atacseq_user_id[name=?]", "atacseq[user_id]"

      assert_select "input#atacseq_name[name=?]", "atacseq[name]"

      assert_select "textarea#atacseq_description[name=?]", "atacseq[description]"

      assert_select "textarea#atacseq_submitter_comments[name=?]", "atacseq[submitter_comments]"

      assert_select "textarea#atacseq_notes[name=?]", "atacseq[notes]"
    end
  end
end
