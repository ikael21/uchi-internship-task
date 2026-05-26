require 'test_helper'

class SchoolClassesTest < ActionDispatch::IntegrationTest
  include ResponseHelper

  test 'GET /schools/:school_id/classes returns school classes' do
    school = schools(:one)

    get "/schools/#{school.id}/classes"

    assert_response :ok

    body = json_response
    assert body[:data].present?
    assert body[:meta].present?
  end
end
