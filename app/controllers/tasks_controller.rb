class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

    def index
      @tasks = Task.order(id: :desc).page(params[:page]).per(3)
    end

    def show
    end

    def new
      @task = Task.new
    end

    def create
      @task = Task.new(task_params)
      
      if @task.save
      flash[:success] = 'メッセージが正常に投稿されました'
      redirect_to @task
      
      else 
      flash.now[:danger] = 'メッセージが投稿されませんでした'
      render :new      
      end
    end
    
    def edit
    end
    
    def update
      if @task.update(task_params)
        flash[:success] = 'メッセージは正常に更新されました'
        redirect_to @task
      else
        flash.now[:danger] = 'メッセージは更新されませんでした'
        render :edit
      end
    end
    
    def destroy
      @task.destroy

      flash[:success] = 'メッセージは正常に削除されました'
      redirect_to tasks_url
    end
    
  private
    def task_params
      params.require(:task).permit(:content, :title, :status)
    end

    def set_task
      @task = Task.find(params[:id])
    end

end