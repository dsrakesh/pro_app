class TasksController < ApplicationController
  before_action :set_task, only: %i[ show edit update]

  # GET /tasks or /tasks.json
  def index
    @project=Project.find(params[:project_id])
    @tasks = @project.tasks.all
  end

  # GET /tasks/1 or /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    project = Project.where(:id => params[:project_id]).first
    @task = project.tasks.new
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks or /tasks.json
  def create
    project = Project.where(:id => params[:project_id]).first
    @task = project.tasks.new(task_params)

    respond_to do |format|
      if @task.save
        format.html {redirect_to "/projects/#{project.id}/tasks", notice: "Task was successfully created."}
        format.json {render :show, status: :created, location: @task}
      else
        format.html {render :new, status: :unprocessable_entity}
        format.json {render json: @task.errors, status: :unprocessable_entity}
      end
    end
  end

  # PATCH/PUT /tasks/1 or /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html {redirect_to "/projects/#{params[:project_id]}/tasks", notice: "Task was successfully updated."}
        format.json {render :show, status: :ok, location: @task}
      else
        format.html {render :edit, status: :unprocessable_entity}
        format.json {render json: @task.errors, status: :unprocessable_entity}
      end
    end
  end

  # DELETE /tasks/1 or /tasks/1.json
  def destroy
    task=Task.find(params[:task_id])
    task.destroy
    respond_to do |format|
      format.html {redirect_to "/projects/#{params[:project_id]}/tasks", notice: "Task was successfully destroyed."}
      format.json {head :no_content}
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_task
    @task = Task.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def task_params
    params.require(:task).permit(:name)
  end
end
