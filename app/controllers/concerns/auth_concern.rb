module AuthConcern
  extend ActiveSupport::Concern

  included do
    def attach_response_token(id)
      response.set_header('X-Auth-Token', AuthTokenService.generate(id))
    end

    def authenticate
      authenticate_or_request_with_http_token do |token, _|
        AuthTokenService.compare(params[:id], token)
      end
    end
  end
end
