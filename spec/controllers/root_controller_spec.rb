require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe RootController do

  it { should route( :get, "/post/1" ).to :controller => "root", :action => "post", :form_id => "1" }
  it { should route( :get, "/status/abcd" ).to :controller => "root", :action => "status", :token => "abcd" }

  context "on GET to :index" do
    before(:each) do
      get :index
    end

    it { should assign_to :user }
    it { should assign_to :user_session }
    it { should respond_with :success }
    it { should render_template :about }
  end

end
