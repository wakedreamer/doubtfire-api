
FactoryBot.define do
    factory :criterion_option do
        transient do
            number_of_feedback_comment_templates {0}
        end

        criterion # associates according to relationship within models
        # association :feedback_comment_template
        # association :feedback_comment
        # association :task_status

        task_status                  { TaskStatus.all.sample }

        # outcome_status
        resolved_message_text        { Faker::Lorem.sentence }
        unresolved_message_text      { Faker::Lorem.sentence }

        after(:create) do |criterion_option, evaluator|
            # create_list(:feedback_comment_template, evaluator.number_of_feedback_comment_templates, criterion_option: criterion_option)
        end
    end
end
