OpenAI.configure do |config|
  config.access_token = Rails.application.credentials.dig(Rails.env.to_sym, :api_key)
  config.organization_id = Rails.application.credentials.dig(Rails.env.to_sym, :organizatoin_id)
end
