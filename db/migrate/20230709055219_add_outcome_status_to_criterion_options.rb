class AddOutcomeStatusToCriterionOptions < ActiveRecord::Migration[7.0]
  def change
    add_column :criterion_options, :outcome_status, :string
  end
end
