class ChatsController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
    @chats = Chat.all
    @user_coords = []
    # REAL ACTUAL QUERY
    # search_result = Geocoder.search(current_user.current_sign_in_ip)
    # HARDCODED QUERY FOR TEST
    search_result = Geocoder.search("204.57.220.1")
    @user_coords << search_result[0].data['latitude']
    @user_coords << search_result[0].data['longitude']
  end

  def new
    @chat = Chat.new
    @chat_location = request.location.coordinates
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
    params.require(:chat).permit(:title, :longitude, :latitude)
  end
end