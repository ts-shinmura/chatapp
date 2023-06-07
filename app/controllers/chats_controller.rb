class ChatsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_chats
  before_action :set_chat, only: %i[show]

  def new
    chat = current_user.chats.where.not(id: Message.select(:chat_id)).first
    chat ||= current_user.chats.create!
    redirect_to chat_path(chat), status: :see_other
  end

  alias index new

  def show; end

  def create
    @chat = current_user.chats.create!
  end

  private

  def set_chats
    @chats = current_user.chats.where(id: Message.select(:chat_id)).order(id: :desc)
  end

  def set_chat
    @chat = Chat.find(params[:id])
  end
end
