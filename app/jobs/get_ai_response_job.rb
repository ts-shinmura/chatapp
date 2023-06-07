class GetAiResponseJob < ApplicationJob
  include ActionView::RecordIdentifier

  queue_as :default

  def perform(chat_id)
    chat = Chat.find(chat_id)
    call_openai(chat: chat)
  end

  private

  def call_openai(chat:)
    message = chat.messages.create(role: 'assistant', content: '')
    Turbo::StreamsChannel.broadcast_append_to(
      "#{dom_id(chat)}_messages", partial: "messages/message",
      locals: { message: message, scroll_to: true }, target: "#{dom_id(chat)}_messages")

    client = OpenAI::Client.new
    client.chat(parameters: { **Rails.application.config.chat_gpt.dig(:parameters),
                              messages: chat.messages.for_openai(Rails.application.config.chat_gpt.dig(:length)),
                              stream: stream_proc(message:, chat:, client:) })
  end

  def stream_proc(message:, chat:, client:)
    proc do |chunk, _bytesize|
      puts chunk.to_yaml
      new_content = chunk.dig('choices', 0, 'delta', 'content')
      if chunk.dig('choices', 0, 'finish_reason').present?
        if chat.title.blank?
          chat.update_title! client
          Turbo::StreamsChannel.broadcast_replace_later_to(
            "#{dom_id(chat)}_title", partial: 'chats/title',
            locals: { chat: chat }, target: "#{dom_id(chat)}_title")
          Turbo::StreamsChannel.broadcast_prepend_later_to(
            "#{dom_id(chat.user)}_chats", partial: 'chats/chat',
            locals: { chat: chat }, target: "#{dom_id(chat.user)}_chats")
        end
        next
      end

      next if new_content.blank?

      message.update(content: message.content + new_content)
      Turbo::StreamsChannel.broadcast_append_later_to(
        "#{dom_id(chat)}_messages", partial: "messages/message",
        locals: { message: message, scroll_to: true }, target: "#{dom_id(chat)}_messages")
    end
  end
end
