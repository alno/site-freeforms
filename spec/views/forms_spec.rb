require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "forms/code.js" do
  
  before do
    assigns[:form] = Form.make

    render 'forms/code.js'
  end

  it "should include fields" do
    response.should have_text(/name="fields\[0\]"/)
    response.should have_text(/name="fields\[1\]"/)
  end
  
end

describe "forms/code.html" do
  
  before do
    assigns[:form] = @form = Form.make

    render 'forms/code.html'
  end

  it "should include fields" do
    response.should have_text(/#{Regexp.quote(@form.title)}/)
    response.should have_text(/#{Regexp.quote(@form.code)}/)
  end
  
end

describe "forms/new.html" do
  
  context "with basic form" do
    
    before do
      assigns[:form] = @form = Form.make_unsaved
  
      render 'forms/new.html'
    end
  
    it "should include form title" do
      response.should have_text(/#{Regexp.quote(@form.title)}/)
    end
    
    it "should include form submit title" do
      response.should have_text(/#{Regexp.quote(@form.submit_title)}/)
    end
  
  end

  context "with form having empty title" do
  
    before do
      assigns[:form] = @form = Form.make_unsaved( :title => '' )

      render 'forms/new.html'
    end

    it "should include form submit title" do
      response.should have_text(/#{Regexp.quote(@form.submit_title)}/)
    end

  end

  context "with form having empty submit title" do
  
    before do
      assigns[:form] = @form = Form.make_unsaved( :submit_title => '' )

      render 'forms/new.html'
    end

    it "should include form title" do
      response.should have_text(/#{Regexp.quote(@form.title)}/)
    end

  end
   
end
