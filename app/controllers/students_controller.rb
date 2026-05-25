class StudentsController < ApplicationController
  wrap_parameters false

  before_action :authenticate, only: :destroy

  def create
    student = Student::CreateForm.new(student_params)
    return render_errors(student) unless student.save

    attach_response_token(student.id)
    render json: StudentSerializer.new(student).serialize, status: :created
  end

  def destroy
    resource_student.destroy
    head :no_content
  end

  private

  def resource_student
    @resource_student ||= Student.find(params[:id])
  end

  def student_params
    params.permit(:first_name, :last_name, :surname, :school_class_id, :school_id)
  end
end
