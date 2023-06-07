class Chat < ApplicationRecord
  belongs_to :user, inverse_of: :chats
  has_many :messages, dependent: :destroy, inverse_of: :chat

  def broadcast_updated
    broadcast_append_to("#{dom_id(chat)}_chat", partial: "chats/chat",
                        locals: { message: self, scroll_to: true }, target: "#{dom_id(chat)}_chat")
  end
end
