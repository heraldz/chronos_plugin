class DashboardController < ApplicationController
  def index
    # retrieve all Agents ordered by descending creation timestamp
    @person = Person.order('created_at desc')
    if current_person.is_admin || current_person.is_supervisor?
      @tasks = Task.all.limit(10)
      @pending_count = Task.where("statuses.name = ?", 'pending').joins(:status).count
      @new_count = Task.where("statuses.name = ?", 'new').joins(:status).count
      @resolved_count = Task.where("resolved_at >= ?", Date.today.at_beginning_of_month).where("statuses.name = ?", 'resolved').joins(:status).count
      @voicemail_count = Task.joins(:status).where("statuses.name = ?", 'new').joins(:task_type).where("task_types.name = ?", 'Voicemail').count
      @broken_count = Task.joins(:status).where("statuses.name = ?", 'new').joins(:task_type).where("task_types.name = ?", 'Broken Report').count
      @idle_count = Task.joins(:status).where("statuses.name = ?", 'new').joins(:task_type).where("task_types.name = ?", 'Idle Report').count
      @unmatched_count = Task.joins(:status).where("statuses.name = ?", 'new').joins(:task_type).where("task_types.name = ?", 'Unmatched').count
      @other_count = Task.joins(:status).where("statuses.name = ?", 'new').joins(:task_type).where("task_types.name = ?", 'Other Tasks').count
      @email_count = Task.joins(:status).where("statuses.name = ?", 'new').joins(:task_type).where("task_types.name = ?", 'email').count
    else
      @tasks = Task.where(:person_id => current_person.id).limit(10)
      @pending_count = Task.where(:person_id => current_person.id).joins(:status).where("statuses.name = ?", 'pending').count
      @new_count = Task.where(:person_id => current_person.id).joins(:status).where("statuses.name = ?", 'new').count
      @resolved_count = Task.where(:person_id => current_person.id).where("resolved_at >= ?", Date.today.at_beginning_of_month).where("statuses.name = ?", 'resolved').joins(:status).count
      @voicemail_count = Task.where(:person_id => current_person.id).joins(:status).where("statuses.name = ?", 'new').joins(:task_type).where("task_types.name = ?", 'Voicemail').count
      @broken_count = Task.where(:person_id => current_person.id).joins(:status).where("statuses.name = ?", 'new').joins(:task_type).where("task_types.name = ?", 'Broken Report').count
      @idle_count = Task.where(:person_id => current_person.id).joins(:status).where("statuses.name = ?", 'new').joins(:task_type).where("task_types.name = ?", 'Idle Report').count
      @unmatched_count = Task.where(:person_id => current_person.id).joins(:status).where("statuses.name = ?", 'new').joins(:task_type).where("task_types.name = ?", 'Unmatched').count
      @other_count = Task.where(:person_id => current_person.id).joins(:status).where("statuses.name = ?", 'new').joins(:task_type).where("task_types.name = ?", 'Other Tasks').count
      @email_count = Task.where(:person_id => current_person.id).joins(:status).where("statuses.name = ?", 'new').joins(:task_type).where("task_types.name = ?", 'email').count
    end    
    @task_types = TaskType.all
    @people = Person.all

  end
end
# Date.today.at_beginning_of_month