class ChatsController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
    @chats = Chat.all
    # @user_location = request.location.coordinates
    @user_location = [37.5, 122.3]
  end

  def new
    @chat = Chat.new
  end

  def create
    @chat = current_user.chats.build(chat_params)
    if @chat.save
      flash[:success] = 'Chat room added!'
      redirect_to chats_path
    else
      render 'new'
    end
  end

  def show
    @chat = Chat.includes(:messages).find_by(id: params[:id])
    @message = Message.new
  end

private

  def chat_params
    params.require(:chat).permit(:title)
  end
end