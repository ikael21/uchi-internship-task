class Student::CreateForm < Student
  include ActiveFormModel

  MAX_NAMES_LENGTH = 255

  permit :first_name, :last_name, :surname, :school_id, :school_class_id

  normalizes :first_name, :last_name, :surname, with: ->(value) { value.strip }

  validates :first_name, :last_name, :surname, presence: true, length: { maximum: MAX_NAMES_LENGTH }

  validate :school_class_belongs_to_school, if: -> { school_class.present? && school.present? }

  private

  def school_class_belongs_to_school
    return if school_class.school_id == school.id

    errors.add(:school_class, :must_belong_to_school)
  end
end
