class AddFeedbackCommentTemplateIdToCriterionOptions < ActiveRecord::Migration[7.0]
  def change
    add_column :criterion_options, :feedback_comment_template_id, :bigint
  end
end
