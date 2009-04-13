require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe FormsController do
  
  before(:each) do
    @form = Form.make
  end

  #Delete this example and add some real ones
  it "should use FormsController" do
    controller.should be_an_instance_of(FormsController)
  end
  
  should_route :get, "/forms/1/code.js", :controller => "forms", :action => "code", :id => "1", :format => "js"
  
  context "on GET to :code" do
    before(:each) do
      get :code, :id => @form.id, :format => :js
    end

    should_assign_to :form
    should_respond_with :success
    should_render_template :code
  end

end
