require 'spec_helper'

describe "pod_libraries/edit" do
  before(:each) do
    @pod_library = assign(:pod_library, stub_model(PodLibrary))
  end

  it "renders the edit pod_library form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", pod_library_path(@pod_library), "post" do
    end
  end
end
