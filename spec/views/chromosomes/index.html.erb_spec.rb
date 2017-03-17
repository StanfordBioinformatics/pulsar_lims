require 'rails_helper'

RSpec.describe "chromosomes/index", type: :view do
  before(:each) do
    assign(:chromosomes, [
      Chromosome.create!(
        :name => "Name",
        :user => nil,
        :reference_genome => nil
      ),
      Chromosome.create!(
        :name => "Name",
        :user => nil,
        :reference_genome => nil
      )
    ])
  end

  it "renders a list of chromosomes" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
