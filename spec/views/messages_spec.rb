require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "messages/show.html" do
  before(:all) do
    @message = Message.make( :read_at => Time.now )
  end
  
  before do
    assigns[:message] = @message

    render 'messages/show.html'
  end

  it "should contain sender info" do
    response.should have_text(/#{Regexp.quote( @message.sender_name )}/)
    response.should have_text(/#{Regexp.quote( @message.sender_email )}/)
  end
  
  it "should contain timestamps" do
    response.should have_text(/#{Regexp.quote( I18n.l( @message.created_at, :format => :long ) )}/)
    response.should have_text(/#{Regexp.quote( I18n.l( @message.read_at, :format => :long ) )}/)
  end
end

describe "messages/index.html" do
  before(:all) do
    @form = Form.make
    @messages = [ Message.make( :read_at => Time.now, :form => @form ), Message.make( :read_at => Time.now, :form => @form ) ]
  end
  
  before do
    assigns[:form] = @form
    assigns[:messages] = @messages

    render 'messages/index.html'
  end

  it "should contain links to messages" do
    @messages.each do |msg|
      response.should have_text(/#{Regexp.quote( message_path( msg ) )}/)
    end
  end
  
  it "should contain messages sender name" do
    @messages.each do |msg|
      response.should have_text(/#{Regexp.quote( msg.sender_name )}/)
    end
  end
  
  it "should contain messages sender email" do
    @messages.each do |msg|
      response.should have_text(/#{Regexp.quote( msg.sender_email )}/)
    end
  end
    
  it "should contain delete icon" do
    response.should have_text(/icons\/delete\.png/)
  end
end

describe "messages/index.html with unread" do
  before(:all) do
    @form = Form.make
    @messages = [ Message.make( :read_at => Time.now, :form => @form ), Message.make( :form => @form ) ]
  end
  
  before do
    assigns[:form] = @form
    assigns[:messages] = @messages

    render 'messages/index.html'
  end

  it "should contain unread icon" do
    response.should have_text(/icons\/newmail\.png/)
  end
  
end