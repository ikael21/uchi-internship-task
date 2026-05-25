class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods
  include AuthConcern
  include ApiErrorConcern

  rescue_from ActionController::ParameterMissing do |e|
    render_errors field: e.param.to_s, type: 'blank', message: I18n.t('errors.messages.blank')
  end

  rescue_from ActiveRecord::RecordNotFound do |e|
    render_errors field: e.model.downcase, type: 'not_found', message: e.message, status: :not_found
  end
end
