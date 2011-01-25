require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "root/about.html" do
  before { render }

  it "should include link to root" do
    rendered.should include root_path
  end
end
