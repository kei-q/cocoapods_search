require 'spec_helper'

describe "pod_libraries/new" do
  before(:each) do
    assign(:pod_library, stub_model(PodLibrary).as_new_record)
  end

  it "renders new pod_library form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", pod_libraries_path, "post" do
    end
  end
end
