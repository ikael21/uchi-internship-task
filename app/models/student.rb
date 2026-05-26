class Student < ApplicationRecord
  belongs_to :school
  belongs_to :school_class

  scope :for_class_in_school, ->(school_id, school_class_id) { where(school_id:, school_class_id:) }
end
