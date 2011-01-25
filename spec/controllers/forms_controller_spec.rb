require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe FormsController do

  before(:each) do
    @form = Form.make
  end

  it { should route( :get, "/forms/1/code.js" ).to :controller => "forms", :action => "code", :id => "1", :format => "js" }

  context "on GET to :code" do
    before(:each) do
      get :code, :id => @form.id, :format => :js
    end

    it { should assign_to :form }
    it { should respond_with :success }
    it { should render :template => :code }
  end

end
