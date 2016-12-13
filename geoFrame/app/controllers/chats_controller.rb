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
    @chat_room = current_user.chat_rooms.build(chat_room_params)
    if @chat_room.save
      flash[:success] = 'Chat room added!'
      redirect_to chat_rooms_path
    else
      render 'new'
    end
  end

private

  def chat_room_params
    params.require(:chat_room).permit(:title)
  end
end