class TasksController < ApplicationController
    def index
      # コード例: タスクの一覧を表示
      @tasks = Task.all
    end
end
