class RootController < ApplicationController

  def index
    @user = User.new
    @user_session = UserSession.new
  end
  
  def post
    @form = Form.find(params[:form_id]) # Форма, в которую постится собщение
    
    @message = Message.new
    @message.form = @form
    @message.user = @form.user
    @message.data = []
    
    @form.fields.each_with_index do |field,i|
      @message.data << ( field.enabled? ? params[:fields][i.to_s] : field.default )      
    end
    
    if @message.save
      render :js => "mf_#{@message.form_id}.onSuccess('#{@message.token}')"
    else
      render :js => "mf_#{@message.form_id}.onError(#{@message.errors.to_json})"
    end
  end
  
  def status
    @message = Message.find_by_token(params[:token])
  end
    
end
