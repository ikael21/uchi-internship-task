module AuthTokenService
  class << self
    def generate(id)
      Digest::SHA256.hexdigest("#{id}#{Rails.configuration.x.auth.token_salt}")
    end

    def compare(id, token)
      ActiveSupport::SecurityUtils.secure_compare(token, generate(id))
    end
  end
end
