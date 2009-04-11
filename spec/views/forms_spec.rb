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
    response.should have_text(/Отправить сообщение/)
    response.should have_text(/#{Regexp.quote(@form.code)}/)
  end
end