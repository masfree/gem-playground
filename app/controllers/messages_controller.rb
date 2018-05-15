class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :edit, :update, :destroy]

  def index
    @messages = Message.all
  end

  def show
  end

  def new
    @message = Message.new
  end

  def edit
  end

  def create
    @message = Message.new(message_params)
    @message.user = current_user

    if @message.save
      redirect_to messages_url, notice: 'Message was successfully created.'
    else
      redirect_to messages_url, notice: "Message can't be empty"
    end
  end

  def update
    if @message.update(message_params)
      redirect_to messages_url, notice: 'Message was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @message.destroy
    redirect_to messages_url, notice: 'Message was successfully destroyed.'
  end

  private
    def set_message
      @message = Message.find(params[:id])
    end

    def message_params
      params.require(:message).permit(:text)
    end
end
