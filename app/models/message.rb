class Message < ApplicationRecord
  include ActionView::RecordIdentifier

  enum role: { system: 0, assistant: 10, user: 20 }

  belongs_to :chat, inverse_of: :messages

  def for_openai
    { role:, content: }
  end

  def self.for_openai(length = nil)
    content_length = 0
    result = all.map(&:for_openai)

    if length.present?
      result.reverse.take_while do |item|
        content_length += item[:content]&.length.to_i
        content_length < length
      end.reverse
    else
      result
    end
  end
end
