require 'rails_helper'

RSpec.describe "chipseq_experiments/new", type: :view do
  before(:each) do
    assign(:chipseq_experiment, ChipseqExperiment.new(
      :user => nil,
      :name => "MyString",
      :description => "MyText",
      :upstream_identifier => "MyString",
      :target => nil,
      :submitter_comments => "MyText",
      :notes => "MyText"
    ))
  end

  it "renders new chipseq_experiment form" do
    render

    assert_select "form[action=?][method=?]", chipseq_experiments_path, "post" do

      assert_select "input#chipseq_experiment_user_id[name=?]", "chipseq_experiment[user_id]"

      assert_select "input#chipseq_experiment_name[name=?]", "chipseq_experiment[name]"

      assert_select "textarea#chipseq_experiment_description[name=?]", "chipseq_experiment[description]"

      assert_select "input#chipseq_experiment_upstream_identifier[name=?]", "chipseq_experiment[upstream_identifier]"

      assert_select "input#chipseq_experiment_target_id[name=?]", "chipseq_experiment[target_id]"

      assert_select "textarea#chipseq_experiment_submitter_comments[name=?]", "chipseq_experiment[submitter_comments]"

      assert_select "textarea#chipseq_experiment_notes[name=?]", "chipseq_experiment[notes]"
    end
  end
end
