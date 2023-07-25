class CriterionOption < ApplicationRecord
  # Associations
  belongs_to :criterion
  has_one :task_status
  belongs_to :feedback_comment_template, optional: true
  has_many :feedback_comments

  # Constraints
  validates_associated :criterion
end
