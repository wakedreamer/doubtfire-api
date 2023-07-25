class FeedbackCommentTemplate < ApplicationRecord
  # Associations
  has_many :criterion_option

  # Constraints
  validates :comment_text_situation, presence: true
end
