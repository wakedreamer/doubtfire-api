require 'grape'

module FeedbackApi
  class StageApi < Grape::API
    desc 'Feedback is provided in stages. This endpoint allows you to create a new stage for feedback on tasks for a given task definition.'
    params do
      requires :task_definition_id, type: Integer, desc: 'The task definition to which the stage belongs'
      requires :title, type: String,  desc: 'The title of the new stage'
      requires :order, type: Integer, desc: 'The order in which to display the stages'
      optional :entry_message, type: String, desc: 'The message to display to students when they enter the stage'
      optional :exit_message_good, type: String, desc: 'The message to display to students who have achieved a passable level of work'
      optional :exit_message_resubmit, type: String, desc: 'The message to display to students who have not achieved a passable level of work'
    end
    post '/stages' do
      task_definition = TaskDefinition.find(params[:task_definition_id])

      unless authorise? current_user, task_definition.unit, :update
        error!({ error: 'Not authorised to create a stage for this unit' }, 403)
      end

      stage_parameters = ActionController::Parameters.new(params)
                                                     .permit(:title, :order) # only `:title` and `:order` fields of the Stage model can be set directly from the user input.

      stage_parameters[:task_definition] = task_definition

      result = Stage.create!(stage_parameters)

      present result, with: Entities::FeedbackEntities::StageEntity
    end

    desc 'This endpoint allows you to get all the stages for a given task definition.'
    params do
      requires :task_definition_id, type: Integer, desc: 'The task definition to which the stage belongs'
    end
    get '/stages' do
      task_definition = TaskDefinition.find(params[:task_definition_id])

      unless authorise? current_user, task_definition.unit, :provide_feedback
        error!({ error: 'Not authorised to get feedback stages for this unit' }, 403)
      end

      present task_definition.stages, with: Entities::FeedbackEntities::StageEntity
    end

    desc 'This endpoint allows you to update the name and order of a stage.'
    params do
      optional :title, type: String,  desc: 'The new title for the stage'
      optional :order, type: Integer, desc: 'The order value for the stage'
    end
    put '/stages/:id' do
      # Get the stage from the task definition
      stage = Stage.find(params[:id])

      unless authorise? current_user, stage.unit, :update
        error!({ error: 'Not authorised to update feedback stages for this unit' }, 403)
      end

      stage_params = ActionController::Parameters.new(params)
                                                 .permit(:title, :order)

      stage.update!(stage_params)

      present stage, with: Entities::FeedbackEntities::StageEntity
    end

    desc 'This endpoint allows you to delete a stage.'
    delete '/stages/:id' do
      # Get the stage from the task definition
      stage = Stage.find(params[:id])

      unless authorise? current_user, stage.unit, :update
        error!({ error: 'Not authorised to delete feedback stages for this unit' }, 403)
      end

      stage.destroy!
    end
  end
end
