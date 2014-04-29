require 'spec_helper'

describe "authors/index" do
  before(:each) do
    assign(:authors, [
      stub_model(Author),
      stub_model(Author)
    ])
  end

  it "renders a list of authors" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
