class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token, only: %i[consume]

  def consume
    @response = OneLogin::RubySaml::Response.new params['SAMLResponse'],
                                                 settings: Rails.application.config.saml,
                                                 allowed_clock_drift: 10
    return unless @response.is_valid?

    user = User.find_by(email: @response.nameid) || User.create!(email: @response.nameid)
    sign_in user
    redirect_to :chats
  end

  private

  def sign_in(user)
    @current_user = user
    session[:user_id] = user.id
  end

  def current_user
    @current_user ||= (User.find_by(id: session[:user_id]) if session[:user_id].present?)
  end

  def authenticate_user!
    return if current_user.present?

    if %w[development test].include? Rails.env
      sign_in User.first
    else
      request = OneLogin::RubySaml::Authrequest.new
      redirect_to request.create(Rails.application.config.saml), allow_other_host: true
    end
  end
end
