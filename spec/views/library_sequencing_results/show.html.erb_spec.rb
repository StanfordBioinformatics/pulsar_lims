require 'rails_helper'

RSpec.describe "library_sequencing_results/show", type: :view do
  before(:each) do
    @library_sequencing_result = assign(:library_sequencing_result, LibrarySequencingResult.create!(
      :name => "Name",
      :sequencing_result => nil,
      :library => nil,
      :comment => "MyText",
      :read1_uri => "Read1 Uri",
      :read2_uri => "Read2 Uri",
      :read1_count => 2,
      :read2_count => 3
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/Read1 Uri/)
    expect(rendered).to match(/Read2 Uri/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
  end
end
