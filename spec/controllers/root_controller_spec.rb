require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe RootController do

  it "should use RootController" do
    controller.should be_an_instance_of(RootController)
  end
  
  should_route :get, "/post/1", :controller => "root", :action => "post", :form_id => "1"
  should_route :get, "/status/abcd", :controller => "root", :action => "status", :token => "abcd"

  context "on GET to :index" do
    before(:each) do
      get :index
    end

    should_assign_to :user
    should_assign_to :user_session
    should_respond_with :success
    should_render_template :index
  end
  
end
