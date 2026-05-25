class ApiErrorSerializer < ApplicationSerializer
  root_key :error, :errors

  attributes :field, :type, :message
end
