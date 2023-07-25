class AddIndexToCriterionOptions < ActiveRecord::Migration[7.0]
  def change
    add_index :criterion_options, :feedback_comment_template_id
  end
end
