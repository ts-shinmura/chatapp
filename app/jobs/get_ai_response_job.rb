class GetAiResponseJob < ApplicationJob
  queue_as :default

  def perform(chat_id)
    chat = Chat.find(chat_id)
    call_openai(chat: chat)
  end

  private

  def call_openai(chat:)
    message = chat.messages.create(role: 'assistant', content: '')
    message.broadcast_created

    client = OpenAI::Client.new

    client.chat(parameters: { model: 'gpt-3.5-turbo', messages: chat.messages.for_openai,
                              temperature: 0.7, stream: stream_proc(message: message) }).tap { |x| puts x.inspect }
  end

  def stream_proc(message:)
    proc do |chunk, _bytesize|
      puts chunk.to_yaml
      new_content = chunk.dig('choices', 0, 'delta', 'content')
      message.update(content: message.content + new_content) if new_content
    end
  end
end
