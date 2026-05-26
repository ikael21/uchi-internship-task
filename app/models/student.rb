class Student < ApplicationRecord
  belongs_to :school
  belongs_to :school_class, counter_cache: true

  scope :for_class_in_school, ->(school_id, school_class_id) { where(school_id:, school_class_id:) }
end
