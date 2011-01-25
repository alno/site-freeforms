require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe MessagesHelper do

  #Delete this example and add some real ones or delete this file
  it "should be included in the object returned by #helper" do
    included_modules = (class << helper; self; end).send :included_modules
    included_modules.should include(MessagesHelper)
  end

  before :all do
    @form = Form.make :fields => [ Form::StringField.new, Form::TextField.new, Form::EmailField.new ]
  end

  it "should render message body" do
    @msg = Message.make_unsaved :form => @form, :data => [ Sham.title, Sham.body, Sham.email ]

    body = helper.message_body @msg
    body.should_not be_nil
    body.should include(@msg.data[0])
    body.should_not include(@msg.data[1])
    body.should include(@msg.data[2])
  end

  it "should render message body with empty fields" do
    @msg = Message.make_unsaved :form => @form, :data => [ nil, Sham.body, nil ]

    helper.message_body( @msg ).should_not be_nil
  end

end
