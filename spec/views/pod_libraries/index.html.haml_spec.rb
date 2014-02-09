require 'spec_helper'

describe "pod_libraries/index" do
  before(:each) do
    assign(:pod_libraries, [
      stub_model(PodLibrary),
      stub_model(PodLibrary)
    ])
  end

  it "renders a list of pod_libraries" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
