class AddDayOfWeekToTrainingLogs < ActiveRecord::Migration[7.2]
  def change
    add_column :training_logs, :day_of_week, :string
  end
end
