require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "root/about.html" do
  before do
    render 'root/about.html'
  end

  it "should include link to root" do
    response.should have_text(/#{root_path}/)
  end
end