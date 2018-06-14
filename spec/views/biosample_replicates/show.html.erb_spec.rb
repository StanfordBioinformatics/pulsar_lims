require 'rails_helper'

RSpec.describe "biosample_replicates/show", type: :view do
  before(:each) do
    @biosample_replicate = assign(:biosample_replicate, BiosampleReplicate.create!(
      :user => nil,
      :name => "Name",
      :upstream_identifier => "Upstream Identifier",
      :biological_replicate_number => 2,
      :technical_replicate_number => 3,
      :notes => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Upstream Identifier/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/MyText/)
  end
end
