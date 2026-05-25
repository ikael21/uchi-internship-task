require 'test_helper'

class StudentsTest < ActionDispatch::IntegrationTest
  include ResponseHelper

  setup do
    @school = schools(:one)
    @school_class = school_classes(:one)
    @other_school_class = school_classes(:three)
  end

  test 'POST /students creates a student and returns token' do
    params = {
      first_name: 'First',
      last_name: 'Last',
      surname: 'Surname',
      school_id: @school.id,
      school_class_id: @school_class.id
    }

    assert_difference('Student.count', 1) do
      post '/students', params: params, as: :json
    end

    assert_response :created
    assert response.headers['X-Auth-Token'].present?

    student = Student.find(json_response[:id])
    assert_equal params[:first_name], student.first_name
    assert_equal @school.id, student.school_id
    assert_equal @school_class.id, student.school_class_id
  end

  test 'POST /students fails when one of params missing' do
    params = {
      school_id: @school.id,
      school_class_id: @school_class.id
    }

    assert_no_difference('Student.count') do
      post '/students', params: params, as: :json
    end

    assert_response :unprocessable_entity
    assert response.headers['X-Auth-Token'].blank?

    blank_error_message = I18n.t('errors.messages.blank')
    expected_errors = [
      { field: 'first_name', type: 'blank', message: blank_error_message },
      { field: 'last_name', type: 'blank', message: blank_error_message },
      { field: 'surname', type: 'blank', message: blank_error_message }
    ]
    assert_equal expected_errors, json_response[:errors]
  end

  test 'POST /students fails when class belongs to another school' do
    params = {
      first_name: 'First',
      last_name: 'Last',
      surname: 'Surname',
      school_id: @school.id,
      school_class_id: @other_school_class.id
    }

    assert_no_difference('Student.count') do
      post '/students', params: params, as: :json
    end

    assert_response :unprocessable_entity

    error_message = I18n.t('activerecord.errors.models.student.attributes.school_class.must_belong_to_school')
    expected_errors = [{ field: 'school_class', type: 'must_belong_to_school', message: error_message }]
    assert_equal expected_errors, json_response[:errors]
  end

  test 'DELETE /students/:id deletes student with valid token' do
    student = students(:to_delete)
    token = AuthTokenService.generate(student.id)

    assert_difference('Student.count', -1) do
      delete "/students/#{student.id}", headers: { 'Authorization' => "Bearer #{token}" }
    end

    assert_response :no_content
  end

  test 'DELETE /students/:id fails with invalid token' do
    student = students(:to_delete)

    delete "/students/#{student.id}", headers: { 'Authorization' => 'Bearer invalid-token' }

    assert_response :unauthorized
    assert Student.exists?(student.id)
  end

  test 'DELETE /students/:id fails without token' do
    student = students(:to_delete)

    delete "/students/#{student.id}"

    assert_response :unauthorized
    assert Student.exists?(student.id)
  end

  test 'DELETE /students/:id fails with non existing student' do
    student = students(:to_delete)
    token = AuthTokenService.generate(student.id)
    student.destroy

    delete "/students/#{student.id}", headers: { 'Authorization' => "Bearer #{token}" }

    assert_response :not_found
  end
end
