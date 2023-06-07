class Chat < ApplicationRecord
  include ActionView::RecordIdentifier

  belongs_to :user, inverse_of: :chats
  has_many :messages, dependent: :destroy, inverse_of: :chat

  def update_title!(client)
    response = client.chat(
      parameters: { **Rails.application.config.chat_gpt.dig(:parameters),
                    messages: [*messages.for_openai[0, 2], { role: 'user', content: '20文字のタイトル' }] })
    self.title = response.dig("choices", 0, "message", "content")&.gsub('/[「」]/', '')
    save!
  end
end
