class RootController < ApplicationController
  
  def post
    @message = Message.new
    @message.user_id = params[:user_id]
    @message.sender_name = params[:name]
    @message.sender_email = params[:email]
    @message.title = params[:title]
    @message.content = params[:content]
    
    if @message.save
      render :text => "messageForm.onSuccess('#{@message.token}')"
    else
      render :text => "messageForm.onError(#{@message.errors.to_json})"
    end
  end
  
  def status
    @message = Message.find_by_token(params[:token])
  end
  
end
