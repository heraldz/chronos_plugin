class TasksController < ApplicationController
  handles_sortable_columns
  before_action :set_task, only: [:show, :edit, :update, :destroy, :resolved, :pending, :unpending]
  
  helper_method :is_admin?
  # GET /tasks
  # GET /tasks.json
  def index
    order = sortable_column_order
    @tasks = Task.search(params[:search]).order(order).paginate(:per_page => 10, :page => params[:page])
    #@task = Task.search(params[:search]).order(sort_column + " " + sort_direction).paginate(:per_page => 5, :page => params[:page])
    @task_types = TaskType.all
    @people = Person.all
  end
  
  # GET /tasks/1
  # GET /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = Task.new(task_params)
    @task.created_by = current_person.id
    @task.imported = 0
    respond_to do |format|
      if @task.save
        format.html { redirect_to tasks_path, notice: 'Task was successfully created.' }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to tasks_path, notice: 'Task was successfully updated.' }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url, notice: 'Task was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def import
    Task.import(params[:file], current_person.id, params[:task_type_id][:task_type], params[:people_id][:full_name])
    redirect_to tasks_path, notice: "Task properly imported."
  end

  def unpending
    @task.update_attribute(:status_id, 1)
    #redirect_to :back, notice: "Task set to New"
    
    respond_to do |format|
      flash[:success] = "Task updated"
      format.html { redirect_to :back }
      format.js
    end  
  end
    
  def resolved
    @task.update_attributes(:status_id => 3, :resolved_at => Date.today)
    redirect_to :back, notice: "Task set to Resolved"
  end
  
  def pending
    @task.update_attribute(:status_id, 2)
    redirect_to :back, notice: "Task set to Pending"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:title, :email, :source_id, :task_type_id, :person_id, :status_id, :created_by)
    end
end
