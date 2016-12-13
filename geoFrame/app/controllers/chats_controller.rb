class ChatsController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
    @chats = Chat.all
  end

  def new
    @chat = Chat.new
  end

  def show
    @chat = Chat.includes(:messages).find_by(id: params[:id])
  end

  def create
    @chat = current_user.chat.build(chat_params)
    if @chat.save
      flash[:success] = 'Chat room added!'
      redirect_to chat_path
    else
      render 'new'
    end
  end

private

  def chat_params
    params.require(:chat).permit(:title)
  end
end