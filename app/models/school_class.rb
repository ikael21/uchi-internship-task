class SchoolClass < ApplicationRecord
  belongs_to :school

  has_many :students, dependent: :destroy

  scope :for_school, ->(school_id) { where(school_id:) }
end
