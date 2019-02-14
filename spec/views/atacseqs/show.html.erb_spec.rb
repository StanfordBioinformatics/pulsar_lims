require 'rails_helper'

RSpec.describe "atacseqs/show", type: :view do
  before(:each) do
    @atacseq = assign(:atacseq, Atacseq.create!(
      :user => nil,
      :name => "Name",
      :description => "MyText",
      :submitter_comments => "MyText",
      :notes => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/MyText/)
  end
end
