require 'rails_helper'

RSpec.describe "chipseq_experiments/show", type: :view do
  before(:each) do
    @chipseq_experiment = assign(:chipseq_experiment, ChipseqExperiment.create!(
      :user => nil,
      :name => "Name",
      :description => "MyText",
      :upstream_identifier => "Upstream Identifier",
      :target => nil,
      :submitter_comments => "MyText",
      :notes => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/Upstream Identifier/)
    expect(rendered).to match(//)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/MyText/)
  end
end
