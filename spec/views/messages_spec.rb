require 'spec_helper'

describe "messages/show.html" do
  before :all do
    @message = Message.make!( :read_at => Time.now )
  end

  before :each do
    assigns[:message] = @message

    render
  end

  it "should contain sender info" do
    rendered.should include @message.data[1]
    rendered.should include @message.data[0]
  end

  it "should contain timestamps" do
    rendered.should include I18n.l( @message.created_at, :format => :long )
    rendered.should include I18n.l( @message.read_at, :format => :long )
  end
end

describe "forms/messages.html" do

  before :all do
    @form = Form.make( :fields => [
      Form::EmailField.new( :title => I18n.t( 'form_fields.email' ), :required => true ),
      Form::StringField.new( :title => I18n.t( 'form_fields.name' ) ),
      Form::StringField.new( :title => I18n.t( 'form_fields.title' ) ),
      Form::TextField.new( :title => I18n.t( 'form_fields.content' ) )
    ])

    @messages = [ Message.make!( :read_at => Time.now, :form => @form ), Message.make!( :read_at => Time.now, :form => @form ) ].paginate
  end

  before :each do
    assigns[:form] = @form
    assigns[:messages] = @messages

    view.stub!(:current_user).and_return(@form.user)

    render
  end

  it "should contain links to messages" do
    @messages.each do |msg|
      rendered.should include message_path( msg )
    end
  end

  it "should contain messages sender name" do
    @messages.each do |msg|
      rendered.should include msg.data[1]
    end
  end

  it "should contain messages sender email" do
    @messages.each do |msg|
      rendered.should include msg.data[0]
    end
  end

  it "should contain delete icon" do
    rendered.should include 'icons/delete.png'
  end
end

describe "forms/messages.html with many messages" do

  before :all do
    @form = Form.make!
    @messages = (1..5).map{ |i| Message.make! :read_at => Time.now, :form => @form }.paginate :per_page => 3
  end

  before :each do
    view.stub! :current_user => @form.user, :url_for => 'some url'

    render :template => 'forms/messages.html'
  end

  it "should contain pager" do
    rendered.should include I18n.t('ui.pagination.next')
  end

end

describe "forms/messages.html with unread" do
  before :all do
    @form = Form.make!
    @messages = [ Message.make!( :read_at => Time.now, :form => @form ), Message.make!( :form => @form ) ].paginate
  end

  before :each do
    assigns[:form] = @form
    assigns[:messages] = @messages

    view.stub!(:current_user).and_return(@form.user)

    render :template => 'forms/messages.html'
  end

  it "should contain unread icon" do
    rendered.should include 'icons/newmail.png'
  end

end
