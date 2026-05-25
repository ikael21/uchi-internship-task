module ApiErrorConcern
  extend ActiveSupport::Concern

  ApiError = Data.define(:field, :type, :message)

  included do
    def render_errors(record = nil, status: :unprocessable_entity, **error_attrs)
      errors = record.present? ? normalize_errors(record) : ApiError[**error_attrs]

      render json: ApiErrorSerializer.new(errors).serialize, status:
    end

    private

    def normalize_errors(record)
      record.errors.map do |error|
        ApiError[field: error.attribute.to_s, type: error.type.to_s, message: error.message]
      end
    end
  end
end
