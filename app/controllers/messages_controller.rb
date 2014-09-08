class MessagesController < ApplicationController
  before_filter :authenticate_user!, except: [:new, :create]

  def new
    @user = User.find(params[:user])
    @message = current_user.messages.new
    
  end
 
  def create
    @recipient = User.find(params[:user])
    current_user.send_message(@recipient, params[:body], params[:subject])
    flash[:notice] = "Message has been sent!"
    redirect_to :conversations
  end
end